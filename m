Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtFP3pbw7F6Gi6vbuzlLVN9EN1prvwRFvm4Rylze9O73FI0iugLjj65jFKKxqnihXC4tkp7
ARC-Seal: i=1; a=rsa-sha256; t=1521483526; cv=none;
        d=google.com; s=arc-20160816;
        b=XPdfgi+mu4EhbF2feyu9FEOCQi8UVyhBu8mAxWoh5ySjixVL7cA/xPZXTVGz8G4W9M
         DXzuwPXtzdf1rPwOgaFeYXyk5+h/8bC94D+nb1NpKqaNX1V3W+NMheaS4XJxKNGWYdqi
         2OEyxrLs8sshDtAYZ/k5pmYfTYTvAI2AQsYBR7Xx79mZWtCtiKNaE+GibA1rvT5rT2PX
         N6aaR2ekEmJ4+kiPo4Ex87KokuTO5oZRT+t3C7ofuo0aPEzwKYhGnVQ6z1/FjEsbTWur
         28d07EEt4wT6+/nHzSsHI2Rc1T/oYJinoRE4yfAbE5arFt1oDTj89liVfbTWu5yMwYYa
         ohIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=f+S2Sf46/EQkp/+YP1ipMTfy7UWW6f6k3ari7x3JtwI=;
        b=ThTXLUWojGy7cgHU1GA8tfMR21pypwjqScB8wAh3cwN6drx66Hr8B5bk38pv3NSzyF
         2Zquoi50J0jyTx4tfWc/NWgDckijQBj9dqiend/oFMUQcoNPz7s4/lZk3hVdoeABnnvp
         g+1Spww7GHavnFBQo4ezAamc9btP+QLxL80zTiDg4UZzwkrPrOyjMzUa/ywChMhkZfny
         SKrI4o2kopI3xkCx9fHC+GYoM4omTCudL33ZoDAKvdUyUFmr5BIze66u2Hn331LRqBt9
         slUHfMpH8oT9vD+p9u8EQEKaBVynX3MhThWIVB/5SQOxx6qa7rlG/HhRIIriSL/anIYW
         1VLA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Changbin Du <changbin.du@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Andi Kleen <ak@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 021/241] perf sort: Fix segfault with basic block cycles sort dimension
Date: Mon, 19 Mar 2018 19:04:46 +0100
Message-Id: <20180319180752.044999756@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390696077368287?=
X-GMAIL-MSGID: =?utf-8?q?1595391110937683505?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Changbin Du <changbin.du@intel.com>


[ Upstream commit 4b0b3aa6a2756e6115fdf275c521e4552a7082f3 ]

Skip the sample which doesn't have branch_info to avoid segmentation
fault:

The fault can be reproduced by:

  perf record -a
  perf report -F cycles

Signed-off-by: Changbin Du <changbin.du@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 0e332f033a82 ("perf tools: Add support for cycles, weight branch_info field")
Link: http://lkml.kernel.org/r/20170313083148.23568-1-changbin.du@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/sort.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -846,6 +846,9 @@ static int hist_entry__mispredict_snprin
 static int64_t
 sort__cycles_cmp(struct hist_entry *left, struct hist_entry *right)
 {
+	if (!left->branch_info || !right->branch_info)
+		return cmp_null(left->branch_info, right->branch_info);
+
 	return left->branch_info->flags.cycles -
 		right->branch_info->flags.cycles;
 }
@@ -853,6 +856,8 @@ sort__cycles_cmp(struct hist_entry *left
 static int hist_entry__cycles_snprintf(struct hist_entry *he, char *bf,
 				    size_t size, unsigned int width)
 {
+	if (!he->branch_info)
+		return scnprintf(bf, size, "%-.*s", width, "N/A");
 	if (he->branch_info->flags.cycles == 0)
 		return repsep_snprintf(bf, size, "%-*s", width, "-");
 	return repsep_snprintf(bf, size, "%-*hd", width,
