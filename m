Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+TNKsFectDI1SY9a7agV2mwMarwWSodnlfw54ib1Leixz5Bs1VrguFC83k/lEYd4T/E30m
ARC-Seal: i=1; a=rsa-sha256; t=1522168371; cv=none;
        d=google.com; s=arc-20160816;
        b=PaumvFy+Y+BH6Cahxy0WM5Ay98OStpJY0AYhHNxyi57alaxyEwrc2oka3hemcKHIJz
         aL7TYJMcuk0Y44y/MaAVH7bOsghQd/9KBXXFYwf09PL/3NDWgqS2bkTy8SK2tE77ellp
         XAw322VmxqChffUdVHng6XHrvwpvTTv926lwweoZkIfryi9GgEBhF7adT8QkJrtBkTwd
         xoqvjGYGD6S8mYHYTt/nfYkOxTd4viPYoEaVNJI9uMhspSD1NJRFpVZZfKAuNKRVSFRO
         faYCJJBlxmnmlmi0Fq8gwnoV72q1gxlS4UDHcBtfw7RcFbxTi79tjuh24ERPlJ1VvE6v
         JMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5naTZX3/eTQULEh3huvgwRd8M2ngfmS3MAA/1OqGWRA=;
        b=ILpDsLCEL+v+g6PX79MRb1FlT2tlrIPNAQQrurEWEeWAq6wl+DNyhatTpthoUbaTcH
         S29d5P9jJyr9K+QzguVe5ptAOGTSZncssRp1lqP7A79Ai5I/worOTtBJbyeGu2puwwaF
         WSHyGMiv04raJn82MvLvcSe1OlQ6Sv1exxQEzTp295J7Gaj5ZjQWJ0qaaKCutOzkjOyp
         4yWl6Oc/Uye8kx/NFIrymufRnmPTplR44/HP9QnBySdoINNQuHNe+JOepMt0qiwO+bwd
         3dJ7+/xuXKSNLGVkWJSJcuKZWVHoBFlvutXUSG07LxeFZ5UdTWcr0FzEhewL1/YtdGn+
         4vHA==
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
Subject: [PATCH 4.9 56/67] perf/x86/intel: Dont accidentally clear high bits in bdw_limit_period()
Date: Tue, 27 Mar 2018 18:27:48 +0200
Message-Id: <20180327162730.680263014@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109068654036273?=
X-GMAIL-MSGID: =?utf-8?q?1596109222293432262?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3025,7 +3025,7 @@ static unsigned bdw_limit_period(struct
 			X86_CONFIG(.event=0xc0, .umask=0x01)) {
 		if (left < 128)
 			left = 128;
-		left &= ~0x3fu;
+		left &= ~0x3fULL;
 	}
 	return left;
 }
