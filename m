Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226oeguBlPFjQhpUyIEsZ6k3bhMkT0oB99dAwmNxe5JLEr2IUlecJYbwucW4ACs+9XL1cWOO
ARC-Seal: i=1; a=rsa-sha256; t=1519218174; cv=none;
        d=google.com; s=arc-20160816;
        b=nY/qTqhojkv4lvROq9dd+VFzB5fVA3730+ER97qLanXIlxSXPi7cU6PX61APurxN60
         /gcXEpi0yVp0Jk0cWoy3opxQY/y04kK5SKUIhgaqZVVgXeZZgXYbkn34/dqCdDsKfxbO
         EAzb0cafRLE7JbM16mYo7fCxKJmStEZCd3uIdebEnb21iWiLcSaT0s/Hp9J5cW2py3vM
         mKGtSmDftRt78B49SmQZ1ba4Pp1KekBsFIeYQHV2SolkRKFf6e/YGcN/hBNaqDPfdmdp
         COAsMZOubJIfHVzz8paA0lZl+KzZwWXK4fhzZWPweU/NF+qwG3Cp8e+Vc0X1CHHvPMYS
         KJLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TSr4gy0ual7OJBGyuYwH4qUkNyvoguPvTvOTejTwg8I=;
        b=FidsXZL1q87mSwNeRh4ObNp0qg36te9oUcu/m4BzRO7N2mdAgsO/eMtGhPkw4l7xCY
         H/GyCyrVauhV6D0gkS54P1HqnRronIyWqWexU3WXAc7r35/NDVEDrsXtfsCi8ZYvh99q
         IZCb3QOzVwzlCWjP2PwvDnn2lMCp0+0KarSf9UCwcUakZAHTzHNxHfjuN1ct09ebtbVx
         Arg5N49FXWFnnuAy59wZjYLH1WK8ix0YmeI+od1J6tEHYwFIFl51AHHtlUFbUdNZkO0O
         /2dnn8ivipCRccU5I8eniiqhR0XMLYPKrXEaaavwBbdVtgoOF+nOKCpC58PXe+RkPiua
         fTSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Harshad Shirwadkar <harshads@google.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.14 106/167] ext4: fix a race in the ext4 shutdown path
Date: Wed, 21 Feb 2018 13:48:37 +0100
Message-Id: <20180221124530.171058007@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015222152228057?=
X-GMAIL-MSGID: =?utf-8?q?1593015716313863921?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harshad Shirwadkar <harshads@google.com>

commit abbc3f9395c76d554a9ed27d4b1ebfb5d9b0e4ca upstream.

This patch fixes a race between the shutdown path and bio completion
handling. In the ext4 direct io path with async io, after submitting a
bio to the block layer, if journal starting fails,
ext4_direct_IO_write() would bail out pretending that the IO
failed. The caller would have had no way of knowing whether or not the
IO was successfully submitted. So instead, we return -EIOCBQUEUED in
this case. Now, the caller knows that the IO was submitted.  The bio
completion handler takes care of the error.

Tested: Ran the shutdown xfstest test 461 in loop for over 2 hours across
4 machines resulting in over 400 runs. Verified that the race didn't
occur. Usually the race was seen in about 20-30 iterations.

Signed-off-by: Harshad Shirwadkar <harshads@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inode.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3724,10 +3724,18 @@ static ssize_t ext4_direct_IO_write(stru
 		/* Credits for sb + inode write */
 		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
 		if (IS_ERR(handle)) {
-			/* This is really bad luck. We've written the data
-			 * but cannot extend i_size. Bail out and pretend
-			 * the write failed... */
-			ret = PTR_ERR(handle);
+			/*
+			 * We wrote the data but cannot extend
+			 * i_size. Bail out. In async io case, we do
+			 * not return error here because we have
+			 * already submmitted the corresponding
+			 * bio. Returning error here makes the caller
+			 * think that this IO is done and failed
+			 * resulting in race with bio's completion
+			 * handler.
+			 */
+			if (!ret)
+				ret = PTR_ERR(handle);
 			if (inode->i_nlink)
 				ext4_orphan_del(NULL, inode);
 
