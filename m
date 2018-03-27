Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx496s3d54cWNNWPN9uMqC9GBcGA34S2MgiXVCY3J5AGPDX+4qmzj6dwxabKpS+3LSa08gPmZ
ARC-Seal: i=1; a=rsa-sha256; t=1522168671; cv=none;
        d=google.com; s=arc-20160816;
        b=x7cHYTDBRX9M+Um5Abp7UTyZbVma31oFO8YRi1AsDulYki/nKtpWyAH26gn3+kEQdA
         9FSWO9ht1wVSdNhDMTgiBe1fsPCitpmJ6epbPwtq3HWd7VvufuAXeeulLftjFxymg8uq
         xpV0b6tDj5uICO4Txq/pU/nahWbEcKm+bmCQ0No2hpA+p5asxegDBdZKIL45+inNMmrI
         44sU0fuQ2/jWHXRLinr+OugJUpYBQ+sjoWlvUAlg1nnvd6mgk7UhXpHgLw7myUUxHiYp
         dB8BkADEiBEv0X4m9bzSBzD+JDKOpTgzMXUkWLQycNg7x0J5wOzA8o5HoYKLT/iegDrN
         PDAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zQC3DgZTuseOwEM0ptofFcpoLuZRJkiOItxkpiAevgc=;
        b=rBaXljlQRl2IWWyHkktuTg/5F7A45dtMkNWloLQXxQXZ2PXi/y9wfEG9dKmmbN8vtY
         XbGbbPVxfC+igHnZYO4DDy5lZ7kPuKl9Oy3Rds/+yDPxne1nlv442zEdphOrltmD/xgY
         gfR2svpwhlssWegmbTbb4Qq645osqVWMgHGyLtJ7D6e0WM017IJjptxcjpdbAGA+Nvbq
         O7Au4gx+FZBcr65lyldrRWlx74kKFDrov6acb7jyIU+isdoIpqEGyQPlkE0aoG23ZaY0
         PpYyjTZ2C9ADBHqEeRRh5cN1TMOqHzCNtSIbKWMIJOeJe+tEkDGOADNiKxQkiL1yWePn
         K1DA==
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
Subject: [PATCH 4.14 090/101] perf/x86/intel: Dont accidentally clear high bits in bdw_limit_period()
Date: Tue, 27 Mar 2018 18:28:02 +0200
Message-Id: <20180327162755.564028966@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109068654036273?=
X-GMAIL-MSGID: =?utf-8?q?1596109537086455980?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
