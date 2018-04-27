Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpLT0cUOntq+gJzEblEmYHIDbqnVXi3MKIPiQ13KndYJpV9eDmuvWJwG9drG/PnPCE5QpSX
ARC-Seal: i=1; a=rsa-sha256; t=1524837887; cv=none;
        d=google.com; s=arc-20160816;
        b=BNZTBbZ+trtgQOWK4sX9E7W1rMz8mBseiZmZ5JMO7Pfcp9KZ1cv/Rs+kS1ziTpbGsG
         Hf8NZZJI5PZD2cFBWboS1EknvzDl6I8MPAcHtMammCKqu9jpRZ4Oq0ISqDjzomunl1U4
         g1fheFTJGGKZT8qRx7ZqR9Eu3hf5jXw3iLRawOq6vbiz3D+gD2RbwUKP/ms030oKkKOk
         sbExE7XTF4awEH+vs0kyC97qBJr88pu1XME9FpHw847wny8JbNekgDtWgsGnrJOseOab
         fHG09Av16uZZecyvqFL2N+S/QjbfGh8WmE/mMwyhk6J8ftj4cmTzL3plQbKuSpCwkFnh
         yBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=1SYWtclqjKFcUAz0ZfPjpDKa96YNXlEBOctNgLrdoQc=;
        b=CgmeXarvdA80hkciX/FXLOPVXGbRFT4JdsGgJXn+fNV5WdzbJoWDuV+Sv08fEa9qsR
         euQLQTI/eYowCbnrxiWcD6ijcKaorBqWIgq/+qFRaxXVKubtdJEYhP5gv7E5GULCCNBW
         h7pSXrssFTCUokAokV6f8mqLXMiZiPc89hc6Q1JFBf3GP6T4rM8Ob98LFE6vJIa4hDUX
         YFSJCxWBKLDBBDsj22DKTsEOVNK6SwmedhY46+kWzt8WpXK+Ajat4Bhk0AVdY1nLgWgW
         lvADLpPjpTqLTg7NxB69+AP9cGPPSQcZZq8vASc87qpekzyIZrDb3z97Ao8ixpG+PRDb
         uqXw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A04821890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <andi@firstfloor.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Stephane Eranian <eranian@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	syzkaller-bugs@googlegroups.com,
	x86@kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.9 20/74] perf: Return proper values for user stack errors
Date: Fri, 27 Apr 2018 15:58:10 +0200
Message-Id: <20180427135710.739093313@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908138120907757?=
X-GMAIL-MSGID: =?utf-8?q?1598908412425638067?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

commit 78b562fbfa2cf0a9fcb23c3154756b690f4905c1 upstream.

Return immediately when we find issue in the user stack checks. The
error value could get overwritten by following check for
PERF_SAMPLE_REGS_INTR.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: syzkaller-bugs@googlegroups.com
Cc: x86@kernel.org
Fixes: 60e2364e60e8 ("perf: Add ability to sample machine state on interrupt")
Link: http://lkml.kernel.org/r/20180415092352.12403-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/events/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9456,9 +9456,9 @@ static int perf_copy_attr(struct perf_ev
 		 * __u16 sample size limit.
 		 */
 		if (attr->sample_stack_user >= USHRT_MAX)
-			ret = -EINVAL;
+			return -EINVAL;
 		else if (!IS_ALIGNED(attr->sample_stack_user, sizeof(u64)))
-			ret = -EINVAL;
+			return -EINVAL;
 	}
 
 	if (attr->sample_type & PERF_SAMPLE_REGS_INTR)
