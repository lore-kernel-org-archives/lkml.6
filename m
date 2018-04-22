Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/q3i3a3smBh5ZbkGUcFKM0ZY3m21W+BGYDjySFsES7foiGRSg3rl2MQxkU6QVQH1aPvN1u
ARC-Seal: i=1; a=rsa-sha256; t=1524405822; cv=none;
        d=google.com; s=arc-20160816;
        b=BTj+ktA1H0nwTP14+ftC+eqxqMEtjmAI8Q68c9OwGVSAUS10oMJZOnNXtnrdtcD7TC
         OeK/meJw8pN1c3lz5lFQTK2PdziWCCnRu8kl7BdvGJmcgdv+RkeSOLGZge5w0jJ8QH2t
         IQkyvyScVXg+JMeCCrU1GxvacyTbPZL/O+bY1pKXEo59FFhwFwdMSPF9iFkW4ia4fWgd
         8gWNdOHMmHX8PAcm+pgZL+cv+U4QU2JSYS0RwwVcPG1c2uddOZOpOOlWhiZ+dCuOO77P
         rP7WYJu2qlEFHiAHHTaBpbppCJXEk8MBs0CazavXfp9nncPQNXbvgPOWCN1Y5vxJkwKC
         lriQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=46Zpm+jbQtaUn+sM4YO0b3FUNAbzvYdNKu0PR9G3kZc=;
        b=mMe2vqhJyaN+BqJ1isjEl6L/cwW9BEXxveaDh2B3g9sqU3udx/HuOD0hAQICgS9J7l
         tpPxVozSV81RAQiHOOce22vYL+CQTaAwITh+J+7W3oWUgIvHS6qw050icxN6XLYpKO6k
         i9Tr2NiKPlaG1SocmI8wXlJcmnzlVs20ACrirC5m8ftyPDYCNqpeTT+l4ZioUAz9JDfJ
         ESYVV/JibeKbMwRaXVSFhz69HQDDyu9KPfTg9ZHJF6Zy+4/RfcJtu3VmwKhTKdP5lQTe
         OXIpvb/lUqdk5lxdVNQ1LrfVDYiF4D2nKpt6xkXpOs0gZL7aDCMTouBLSbC27PenjqG0
         eQoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	syzbot+6bd77b88c1977c03f584@syzkaller.appspotmail.com,
	Jeff Mahoney <jeffm@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 011/164] fs/reiserfs/journal.c: add missing resierfs_warning() arg
Date: Sun, 22 Apr 2018 15:51:18 +0200
Message-Id: <20180422135135.855395349@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454902575626953?=
X-GMAIL-MSGID: =?utf-8?q?1598455359233624634?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Morton <akpm@linux-foundation.org>

commit 9ad553abe66f8be3f4755e9fa0a6ba137ce76341 upstream.

One use of the reiserfs_warning() macro in journal_init_dev() is missing
a parameter, causing the following warning:

  REISERFS warning (device loop0): journal_init_dev: Cannot open '%s': %i journal_init_dev:

This also causes a WARN_ONCE() warning in the vsprintf code, and then a
panic if panic_on_warn is set.

  Please remove unsupported %/ in format string
  WARNING: CPU: 1 PID: 4480 at lib/vsprintf.c:2138 format_decode+0x77f/0x830 lib/vsprintf.c:2138
  Kernel panic - not syncing: panic_on_warn set ...

Just add another string argument to the macro invocation.

Addresses https://syzkaller.appspot.com/bug?id=0627d4551fdc39bf1ef5d82cd9eef587047f7718

Link: http://lkml.kernel.org/r/d678ebe1-6f54-8090-df4c-b9affad62293@infradead.org
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: <syzbot+6bd77b88c1977c03f584@syzkaller.appspotmail.com>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Jeff Mahoney <jeffm@suse.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/reiserfs/journal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2643,7 +2643,7 @@ static int journal_init_dev(struct super
 	if (IS_ERR(journal->j_dev_bd)) {
 		result = PTR_ERR(journal->j_dev_bd);
 		journal->j_dev_bd = NULL;
-		reiserfs_warning(super,
+		reiserfs_warning(super, "sh-457",
 				 "journal_init_dev: Cannot open '%s': %i",
 				 jdev_name, result);
 		return result;
