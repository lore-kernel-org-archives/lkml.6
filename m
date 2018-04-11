Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49xohQY6vfwmEviYgQYIgHV9UytzTbFQJds33AOK4e+IdVrfj+Eg4HTotPoaGRu/0LjLNAa
ARC-Seal: i=1; a=rsa-sha256; t=1523473496; cv=none;
        d=google.com; s=arc-20160816;
        b=aRNxZv0lcdzRceWPFhLePvh9DTyx9TIGEzS4t14PqX3XDMHOjqpRis0bbR2xySPgVy
         M6ET6L0p0psdpqmqaWRU9Dkg4fqGo14HVvHTBZsAbyZQKIdbUTWqlX27cYX3izRFQn1x
         YcFU3wJM3zQGjnH5sSMLvXKSo6FFzJcsNuVa9goCEGDAXnsDVgneAFUM+GGb7PQCi1C0
         9/GLmrPSAYXCT1eKlPkH6EpXOGEGhkj9qtdBPurXlhR2fIusLVm+m0P9BCQpyZbjWmAv
         MFEMVddPvQ9z4pK02OiuOU45rx5Fh6smBUg0xxH704Sy8+u7Zzx2242xHLiKnEafspoW
         nEdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=m4kaC/KGQc9lQV1j9voCeWLOTpFlbCbFanrvKcJmV5s=;
        b=Whkr5j/nnDs9PN0QRo5SS2BXaQa3OxfXJRXMzRXl3LD1d7S01NnQDH4Aa5D/qRkd8c
         DpyuSWMDhzzFatcKG9mEABFBRx1rR7ouSJryglO4ipY3Tu6YooUGOyNc3De+cYsFXwwu
         Lan5lb80bzu0M3AV4eAPTj+Y+LMpnnraS9oj0MKQRbVl4Wy81buKDS0jyp6sqydlFab1
         oLiDco2YhA+PJYtifsw0Oa3FPUfY/suc+stEh7ANpMEuYzWmn24zN9qsLSGD4cIL5Q1N
         FkjSgnM/NwsnsEs7uVPG+bFloTdi/yYNnN1ViX20vQDvZLeLphqMCr1KgmWra/P2iOr6
         rS1A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	David Ahern <dsahern@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 269/310] perf tools: Fix copyfile_offset update of output offset
Date: Wed, 11 Apr 2018 20:36:48 +0200
Message-Id: <20180411183634.217284229@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476847657003802?=
X-GMAIL-MSGID: =?utf-8?q?1597477745513703498?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>


[ Upstream commit fa1195ccc0af2d121abe0fe266a1caee8c265eea ]

We need to increase output offset in each iteration, not decrease it as
we currently do.

I guess we were lucky to finish in most cases in first iteration, so the
bug never showed. However it shows a lot when working with big (~4GB)
size data.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 9c9f5a2f1944 ("perf tools: Introduce copyfile_offset() function")
Link: http://lkml.kernel.org/r/20180109133923.25406-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/util.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -207,7 +207,7 @@ int copyfile_offset(int ifd, loff_t off_
 
 		size -= ret;
 		off_in += ret;
-		off_out -= ret;
+		off_out += ret;
 	}
 	munmap(ptr, off_in + size);
 
