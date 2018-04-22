Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx498Zz8iTm0t2j5Ryk/Ucp1ZriB5Syv3CfEOsvyg8TzfozXao9/dazOR6Lth2YIp/tW9LTAA
ARC-Seal: i=1; a=rsa-sha256; t=1524405761; cv=none;
        d=google.com; s=arc-20160816;
        b=eL12bARwIVCyYwBO1FphBTeJSNpTjeQq6cNk7qmH/rwva8allbOk8u51tbE6RxJzLm
         G22w6k8FpnubcqlPc0TLNdm4ilslN82Dwj5FB5JPz4/Af2gXv29yCZxLFBUZlHn13gmg
         OJP9yf90yaO8v8yNMgcSX+s41888z2XAPe1/LTZ1gRF6HRkJ4FRw2sAYMnFUOC0g9xbW
         40UrkxmTqbuTlq5Dz7Y3uawgt2V53Bsytfki7egwLOTvQ0dIKqM+fP7IHwn3yFY3stEK
         pa+UQ9S1jMFScJE0PSCBW6SVsB3djJz9Y5VLlKdTdW32ilvuKJnoTB8YRZXoGr0uaLBf
         KH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WS+oh46CvW2kNK4bIOpc888d2+72QT7bPutoCKgpqVc=;
        b=iiPB95scFq28/otSVHVbUo5hEbaCXfmLUZCMKznYdcKvCZr0nn0V5e8X0H/yJCWqfz
         M+0yPVhW5i0TkIuZCo4y8MzQbdVLOrb/nxjaW46iPqWlM1334VE0UgBD2tCsPoA1zo0b
         4IRnVJEQ4IO3PEhhspMtnjfCzPdgctEpWYBXt72fxqny12xb/L5CZIojiRxJ3vdkP8tV
         ZMbgqq+BIAvAnv4V9zllT/rEus07T5E7k4XnSpLAV11cfZlNXP5BDo8Z15i4pT565f30
         ImpFaOUMzyMgR6NZ9mkPeL/w4Y8PAerKQFdrNF3sbqihTnd91e/0Lhv9l0egjXBn/4bq
         DPQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	stable@kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.16 185/196] jffs2_kill_sb(): deal with failed allocations
Date: Sun, 22 Apr 2018 15:53:25 +0200
Message-Id: <20180422135113.819883661@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455296001564501?=
X-GMAIL-MSGID: =?utf-8?q?1598455296001564501?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit c66b23c2840446a82c389e4cb1a12eb2a71fa2e4 upstream.

jffs2_fill_super() might fail to allocate jffs2_sb_info;
jffs2_kill_sb() must survive that.

Cc: stable@kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/jffs2/super.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -342,7 +342,7 @@ static void jffs2_put_super (struct supe
 static void jffs2_kill_sb(struct super_block *sb)
 {
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
-	if (!sb_rdonly(sb))
+	if (c && !sb_rdonly(sb))
 		jffs2_stop_garbage_collect_thread(c);
 	kill_mtd_super(sb);
 	kfree(c);
