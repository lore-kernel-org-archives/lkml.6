Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp2JsAHzDAcFD7xe9CQ8Id7TwI7pvSqkzELdJrWlVr4bIN9SdgsmxlMSergrWfOva4s6IN9
ARC-Seal: i=1; a=rsa-sha256; t=1525116428; cv=none;
        d=google.com; s=arc-20160816;
        b=IkNgWpnRgzhjAia5bXKVB+REGDG0VnYMBF4VEBWQf84xeuPuNNFd8G3Tm0bfmk2j8I
         5C+X+ys90wPdE7884uz+zIX5bhav1HJ6kv8reEw1QgVXhm7DdsE9a+KkoPYPq3HUMoHp
         gpFU4QPoH5wvBcKzUwXEWNK6UsRAQ+ruEYipKKeHB6FOFp+BVkdr4qX8nLckCQWVETNI
         kKKu8tHvv8ogMbW91Nx57czWCFa4gOKxd0+528geLASHNF5ywsQ7HFJMENOx4sKqXKM9
         AtbMfL9f4PAMvHYINfVdD6HSpWYqfO5lJlFTNAZcx0Iv50ArulyZc88G2SoL8kAEux4B
         KaIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=OFT7+Nn+WLRYETLFR+pXGjC8JMQm1rpPTK7X1goUXiI=;
        b=F+RJybd1h8W5fi7FPXNJuY8oFnc8w7eH7fUyo34B3u6e5wcN1GYLMAdNZWNN3IJwcM
         Xf/KbMFykvwiLhkw/FnHt6ehOhezGUGtQr2jX7Ot/W6PEPJO0sa0IB2zL9ti79jGVCsY
         guuT4HJXDHVRsw5U+AIXDGRd8D8v43kNOpTiNMDjuaV1qmz664jq6v3TkB1LJq/9FbTP
         CG9SwNWeeB1O9ZVm/W+h5tqFZH455mlVok6BGg8Usga5d7nEyBPXuObu4hCQ6lWYu4Xm
         SgsiFV/xv44xhc/8eDxpEspXfL3TWuNpaeVjjDahxaQzpwVSmLA0JVesfrfZDHcuCX1h
         BNaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D1922DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot+9de458f6a5e713ee8c1a@syzkaller.appspotmail.com,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.14 07/91] random: fix possible sleeping allocation from irq context
Date: Mon, 30 Apr 2018 12:23:49 -0700
Message-Id: <20180430184004.586667586@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200450435122666?=
X-GMAIL-MSGID: =?utf-8?q?1599200483706005817?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -788,7 +788,7 @@ static void crng_initialize(struct crng_
 }
 
 #ifdef CONFIG_NUMA
-static void numa_crng_init(void)
+static void do_numa_crng_init(struct work_struct *work)
 {
 	int i;
 	struct crng_state *crng;
@@ -809,6 +809,13 @@ static void numa_crng_init(void)
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
