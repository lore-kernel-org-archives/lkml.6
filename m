Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48RiRoxSGF39oUd84zqAWf+RhiDFtPbKBX0amAe+Tjtf64LwFCG83cfiy+TFYJN/HHP5V4w
ARC-Seal: i=1; a=rsa-sha256; t=1524405878; cv=none;
        d=google.com; s=arc-20160816;
        b=NWJNXZ4g4QoG5RbYkoGO7lCaTDNYXwAx09nfVHlv6oQ9HZXCKZAw6sL5jVwOwnFjs3
         l18T2BYhTuf/junr3sUCa8ec/d6PlciXINw66x2USKGnZfNI/Z2pRq8yUJFGLxnEcIAb
         SgukOdyXZIVdl+g/pVXBDWvETaoNU1ufyAT/FncfMHrTAhpJpRCgCpKP81N9HJIYe6Bg
         qGGuKpG+STW7ev3isNyQkBsXl2Dbnmqzcxiu15tT/VkFRXk8NH/bpDRE9sQ8F41k6381
         zxKHbOBLy6Ic38WMZ65DGzB2Dwt8V2AAWpXT2VpCH5QGiCDHEbDONGP3exY1Jql8gJRb
         sMOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=s0DvZaawI07h0n5NUqnbHO5/EStYsTgGRG6cNWg23Q4=;
        b=usZWz3O/ssaMQMi7Xj5PkJdcfLKyY9pFzDIIX25uImmC4EsI9a1edV/pVdyWhiaBv/
         5I1v7G93/aVW4xOfULUC5PJcBL3i8srbGe76l3wp7P1TdKd8FGFKXVe9/jsDs1aI0Rem
         NRgSnl57my1lhIlk3WZp94MLhWQH2Lqd9mu7yiuPXwiy5wYZqufmWeEd0wcHLg/6iRKs
         YaWaePflilM790ryPMAa0TQ4hA0Xexwyoe5n+AUZypS4Sv8Bd99t6MVYpmtLkI3AKHfs
         1/Xs2yUeCOh1RzA9uMXMjRPoG3Hi9U37tbzwtVSJo0GJVmoZu4dtxAkLHW9xhpdk1nbb
         kqEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Townsend <mtownsend1973@gmail.com>,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.14 004/164] ubi: fastmap: Dont flush fastmap work on detach
Date: Sun, 22 Apr 2018 15:51:11 +0200
Message-Id: <20180422135135.587727832@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454908575503165?=
X-GMAIL-MSGID: =?utf-8?q?1598455418804171292?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Weinberger <richard@nod.at>

commit 29b7a6fa1ec07e8480b0d9caf635a4498a438bf4 upstream.

At this point UBI volumes have already been free()'ed and fastmap can no
longer access these data structures.

Reported-by: Martin Townsend <mtownsend1973@gmail.com>
Fixes: 74cdaf24004a ("UBI: Fastmap: Fix memory leaks while closing the WL sub-system")
Cc: stable@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/ubi/fastmap-wl.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/mtd/ubi/fastmap-wl.c
+++ b/drivers/mtd/ubi/fastmap-wl.c
@@ -362,7 +362,6 @@ static void ubi_fastmap_close(struct ubi
 {
 	int i;
 
-	flush_work(&ubi->fm_work);
 	return_unused_pool_pebs(ubi, &ubi->fm_pool);
 	return_unused_pool_pebs(ubi, &ubi->fm_wl_pool);
 
