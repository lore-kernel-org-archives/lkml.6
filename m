Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/tqvWukMBUsa4k/LzNgAIUAnTmMBm6o/AH4zaj3ZHg0i/qKbd0creojWyTWuCtzbmGeEC5
ARC-Seal: i=1; a=rsa-sha256; t=1523472640; cv=none;
        d=google.com; s=arc-20160816;
        b=CyZjaKjz8sVvQdZAcx1kWO+JXROrat3Z+0RcknBHgScbsgWMgL0GBhGSYgOprCIGpy
         Iba0H5iLMy+8GhDyz9EwVwIK+urVowqRBG2IF7PvkXvxBpfKmIZ+bOfcxiWO9y6niMfq
         MxaskV3EwWT2Am+V/3CMjUGW11cZU8mVfR3/jK1i264DzgzRGLeLPFUVpmg1NYSzrW2q
         iYNLlOoaxDakqinUEB2MrDEIq70d4fPb42Ai9aAyYKCzDoOHc+HmieD56jOdyDZy2iU7
         PcnFZFAFQiK285ztW34Gt39TeD3KwmuJTSUe0fjq3Dmyt3VgpcQ1ymO5Z3EKG2BzetD9
         1OgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3KEXi3CMupL9v5/UOM+BtOT3lpLEiNOfx9TjUX+CUDw=;
        b=cJ4COva2dS6BkLJ0GZJFIgPzxxbivbtoRa1MOkYE15Pw3IFGemHuqeBRVJslTnoPO/
         JJOHP40ZWSJTDvGpCzcHfWYPnh0JfgcEg8w6C+tv+/e1vpU1Rj7DUoEMBv4eYr2hpvbE
         XIyNtMtz/H/rZDDViei5OIiwCBfkuR9wKcOPJo29EN0mr/RCAbqO2n9ijOL35r7li5FO
         2x4hgdYRAKEQo0ka8B+FB53IyPdu9cj/O1S011jqA5Y0c3wmfS/5DS2I3aO5i3LjNmx4
         6OuimUTycPQN/9kcPHXRsin0vsmyOs+yhGJNhJJR/kJaT5wsytFE4/iyG6IHe+6hQ3xW
         KdvQ==
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
Subject: [PATCH 4.4 158/190] perf tools: Fix copyfile_offset update of output offset
Date: Wed, 11 Apr 2018 20:36:44 +0200
Message-Id: <20180411183601.795787222@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476847657003802?=
X-GMAIL-MSGID: =?utf-8?q?1597476847657003802?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -162,7 +162,7 @@ int copyfile_offset(int ifd, loff_t off_
 
 		size -= ret;
 		off_in += ret;
-		off_out -= ret;
+		off_out += ret;
 	}
 	munmap(ptr, off_in + size);
 
