Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpeeCM7ked7DdJJfO3GqWgIEmn8KuZI0s2j6eZEQzVIOCe+zl3ErEzawBusXYRzi7uBe7oc
ARC-Seal: i=1; a=rsa-sha256; t=1524837625; cv=none;
        d=google.com; s=arc-20160816;
        b=E17pzLMiMXrA3Y7KN3pOc6V1cYZshOfuAqOqVsMg2aFGuTkcExAm5ATzp1HyqnWh7H
         I3hLamr0Ndp6Co7ADz02PPxAfhyB8wney3QWPZx7bw/J5Cb/o2a9bOtuciIcNWdrnw0Q
         RCQ7bJ3df0M1v9bKvj7tQjbUjnQAti30VQHaViH8KooV2HOKjWgrZ3pj5uwNFeRdTDPF
         gtbSnJb1zpKaWj9G3CqkGTs35DwfPcaf/VO5pcrl5OhC1AzPo7pHQkqL/01XEGDFVqe4
         CT4MZV23lmrOzA747+BgQHqL8vmrPzsTOO0KHnFOW3MdI7gVLgLpq9eVDcE1nz2Qrtqk
         OmLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=Siw/NgQ4fbD0m9vHon+xuWAIgyoNXXsGng9iBtR3wSk=;
        b=LlVfgDi8ybdmRmqYT3mvkkYwpJJXoy3TbR/c2nCAy58fMbofyesFMSVm3QYNyMU6VX
         NcyUME7eMsdiahkU6iaA5/Kku6vFkZReIcKXbU8Axgce3bJY2W/FpMqXgfdMZ3NpgBbN
         BTeBTQK3/bqt2y1iwxkrt8llTYqRx4s5ROz0+jRD/FZ3s3l+vY63x3DaTImycpBThCTL
         W7V1Kf2xz1MRTtG4aLTEZKydTKPjT/8kwR+a16G0Qfvp/mRD9DpPFF/aYfhrg1ITdmQ8
         LRMcaJTciH13LbTq8rVl4rHa50shhPGdlBw0ASJZ1RealV6qtWya9CQaZR/xlMm+eI1i
         IZEg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885412185A
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
Subject: [PATCH 3.18 06/24] perf: Return proper values for user stack errors
Date: Fri, 27 Apr 2018 15:57:41 +0200
Message-Id: <20180427135631.850559784@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135631.584839868@linuxfoundation.org>
References: <20180427135631.584839868@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908138120907757?=
X-GMAIL-MSGID: =?utf-8?q?1598908138120907757?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -7348,9 +7348,9 @@ static int perf_copy_attr(struct perf_ev
 		 * __u16 sample size limit.
 		 */
 		if (attr->sample_stack_user >= USHRT_MAX)
-			ret = -EINVAL;
+			return -EINVAL;
 		else if (!IS_ALIGNED(attr->sample_stack_user, sizeof(u64)))
-			ret = -EINVAL;
+			return -EINVAL;
 	}
 
 out:
