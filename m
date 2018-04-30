Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpLCsxUVSGW5Y2ue4+Uh5rlM5oq0Smyt/QbopMU9Ei52MFCYz8nF/xCn6v2+DdxenV0de8l
ARC-Seal: i=1; a=rsa-sha256; t=1525116396; cv=none;
        d=google.com; s=arc-20160816;
        b=Yd2QZfx4HERxIYypAlBdDuXISeqyaxrPUSB94eOONbK7NaYOKbrvLyyNvj7BCs8oEe
         K+CiiBDKFMgqa9NbfOzMAbbpAx39UCxx6+mkiZwpa+Wferdb7ifb3BW4lzJbbDq8E/uu
         xrtZ3PwczjVNl45oudD2jrIBTPLlgVLvfEhN1Vz3kcPBf7QpxH3r14LTi4MYtc0x5TbY
         xydEHJdhKvmbtCk1hR+xxCf2tMZkDLgkJYstDJQHIu1weJ3tOFGQAypu9PI5+UM/WCLf
         Zvs9yrlF0GooS905MlNQB9JLFuguA+Ad6uFCSg3zxqsz2JMiO1guWcIG0rY178Cz1TuR
         ht3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=fwsT52TDIVq8EVzS9lM2Lk02eBCKoHH+USuaI60KFsA=;
        b=Ir/vZQqW77idj+L7LhSM/e4nRbEKeABZZ9qdiHNORQMPAcRxP95Ea9JGueElZCCTWV
         6iprH6BwxbVy/fFy1Xl1KJlBn/dl8BHQbOcN3Ycyi1IV82SoXAAT6CMjwaDbjkacZXtZ
         AERJvWddYrrKSP0EOZ8scCpe1LvXXYfhqOsc3uKlHxJOujpLzeQrIl5if7Ek0CO4y2PX
         N6CWdw7s8A87sYhyM7Nn1wlOLmxAG5s2XQZVo44hMWTDk10FveVT4b7jJdLGydkVB3OB
         tdaDAD86tIt00DSLSwXmoYmWEPHfRQYcVA+Fi0UUf/ZWAahj+gpifAsgPrt+GzuUxHIp
         uCng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDA622DC9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot+9de458f6a5e713ee8c1a@syzkaller.appspotmail.com,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.9 06/61] random: fix possible sleeping allocation from irq context
Date: Mon, 30 Apr 2018 12:24:09 -0700
Message-Id: <20180430183951.848308311@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200450435122666?=
X-GMAIL-MSGID: =?utf-8?q?1599200450435122666?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 6c1e851c4edc13a43adb3ea4044e3fc8f43ccf7d upstream.

We can do a sleeping allocation from an irq context when CONFIG_NUMA
is enabled.  Fix this by initializing the NUMA crng instances in a
workqueue.

Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot+9de458f6a5e713ee8c1a@syzkaller.appspotmail.com
Fixes: 8ef35c866f8862df ("random: set up the NUMA crng instances...")
Cc: stable@vger.kernel.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/random.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -820,7 +820,7 @@ static int crng_fast_load(const char *cp
 }
 
 #ifdef CONFIG_NUMA
-static void numa_crng_init(void)
+static void do_numa_crng_init(struct work_struct *work)
 {
 	int i;
 	struct crng_state *crng;
@@ -841,6 +841,13 @@ static void numa_crng_init(void)
 		kfree(pool);
 	}
 }
+
+static DECLARE_WORK(numa_crng_init_work, do_numa_crng_init);
+
+static void numa_crng_init(void)
+{
+	schedule_work(&numa_crng_init_work);
+}
 #else
 static void numa_crng_init(void) {}
 #endif
