Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227YBR7IKAcZJ3q4cUb/fJKAsLPndPY/H22uqY7Rs8bq3Yjj5QvDS0DfsFccOcOdoHPjcsL/
ARC-Seal: i=1; a=rsa-sha256; t=1519217703; cv=none;
        d=google.com; s=arc-20160816;
        b=N2OEh9oUadbYa/Bs/xRqc5DNsPC11qZmfYbucp3pQkqGdUr7IKWzvUQIAr3rEnILxG
         u1wEz3AzPzWaSGlO0+rCXkLQoqO/jx5bWdtx0uBiwto7FAy2oFnpwlIgzzlJBrhbJ/V+
         B5h7TzWEueU2kUpir3o/TARBqKy4KvGIhvUZBZMKgDpRUoyYZ/Gxn1JKCk9GuhwEwN8f
         jNHFxuVSUVQeJbZDRNKBAJaVNce9SfVQ5f2np9vNnjr6JxPkdBjF37UzEbSUrwqVVDyY
         lFRsFnKF8M6+jGtz20VSfVsDD69iYJXTn3uC07s/c5n7vQC1jTXXq2iN1FL9iUPTXaAM
         85Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kvmYAcmK2L5clYZtmFcLbk3Za8E2LMNDoYZI3LNHseo=;
        b=RXqFBB2Yuf29cZI/SPTLB1amdTcKuG4iXiwpGx6GSae3OXBT5tcSvhJChHfI168e49
         XRQBbMSuLn8UB2Eg65kGmXr21extthMSnZLb/4aMi0LouaYAqrvoalPFrinbfZQ5RHN3
         z7rmgNnwkBG0Yen6nqS9EGAuvwlCX/egdHao84+2DVS6Ke3JMpGqwrIbo2bk0cZscACa
         3NTISof5vwQx5bGNwo9CG7ZJviqzH+hN8f47Tf0iMLBad2HXTdL/cxMEJ1ZxjJhpe+dY
         lDVjbKgVRbEYzMV8Ms4UgbDnWcZMDh1k+It9D0fYABmVR0ywdhdPw1uw2wKShApI9w+F
         h29w==
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
Subject: [PATCH 4.9 07/77] ext4: fix a race in the ext4 shutdown path
Date: Wed, 21 Feb 2018 13:48:16 +0100
Message-Id: <20180221124432.484661745@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015222152228057?=
X-GMAIL-MSGID: =?utf-8?q?1593015222152228057?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3526,10 +3526,18 @@ static ssize_t ext4_direct_IO_write(stru
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
 
