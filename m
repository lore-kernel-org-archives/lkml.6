Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+QeJLomQAkqfjPVIRxQMDQndFk/LU+t2m92S397yKhi5cq7XPjvpoyjPLGE8asuYzVIr9b
ARC-Seal: i=1; a=rsa-sha256; t=1522168973; cv=none;
        d=google.com; s=arc-20160816;
        b=ULqocoTP6YJn6HHrl/Z1ni7vHkJtJvdUOsV0tmFeUtG3o7XGxt5OsWAPKFjiBLpEd4
         1rK1V8Jgnew2+vIGt02lqUZKzG0qn9vOE7dzHeIQN/WJ9ibliPgdL3miNonuoBoJEnbH
         8LNoMLpq+M7sMJv5r7jqqsxbML/oxXhmFuClYfvUZ9HBzrHof03/Tdj2mN/NH6GalWH+
         B3+aYWoSL0WBfevZI8LRt99YMDlp3SoRWLa25md7w/0jXWTRHr9lE531mKCfirAPq21H
         3+nh61qt0ixFBp/s5vYL0adxWJhzxOT47u8QJhqV7ifed7JK+53GNSGobCIlAG2XSG/N
         MgPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oq0tP2409YiiaNNE0yPPZbZYurCOmU40KYjqTHhAqbs=;
        b=BU1af2NeKuHjBVx9Hzv4ub8bFkVuKX5aQlq0mWchTYYzN2PBciLE97QHEgnQIfwHZ7
         XDQMJAWMxsFW2fzUvWZac5ebq2DggduHc3J9oDaHNHBi92Cta9BrsjvV7TQNduO7+Y5B
         EsqMztXsFzgNGOgttDhen3yA6BRfI97LK97WMsQ36EcbsPEJ00ZzRe6Wad3+6LJ3nzqD
         a37/SDCa8sQJD5dDgqwd4Y6daEOOeqG1K9pgdSdddq1Q31vUDaaEp8a7y3ckMnutflRH
         mG8ck3NCbYx+I0T7n+1m0J7raK0wj5cZeMqxfHgT9o0v9N3y61+ukPdtZC1XuClVIASX
         mplw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Stephane Eranian <eranian@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vince Weaver <vincent.weaver@maine.edu>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 097/105] perf/x86/intel: Dont accidentally clear high bits in bdw_limit_period()
Date: Tue, 27 Mar 2018 18:28:17 +0200
Message-Id: <20180327162803.953773572@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109068654036273?=
X-GMAIL-MSGID: =?utf-8?q?1596109854017282746?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit e5ea9b54a055619160bbfe527ebb7d7191823d66 upstream.

We intended to clear the lowest 6 bits but because of a type bug we
clear the high 32 bits as well.  Andi says that periods are rarely more
than U32_MAX so this bug probably doesn't have a huge runtime impact.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: 294fe0f52a44 ("perf/x86/intel: Add INST_RETIRED.ALL workarounds")
Link: http://lkml.kernel.org/r/20180317115216.GB4035@mwanda
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/intel/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3194,7 +3194,7 @@ static unsigned bdw_limit_period(struct
 			X86_CONFIG(.event=0xc0, .umask=0x01)) {
 		if (left < 128)
 			left = 128;
-		left &= ~0x3fu;
+		left &= ~0x3fULL;
 	}
 	return left;
 }
