Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt2oWriByx0rII+tYVdxQu98wrHoA2/KggXKCZatMhSJ8tytt3zLWgA2YAYzVU9gGydoHF6
ARC-Seal: i=1; a=rsa-sha256; t=1521483131; cv=none;
        d=google.com; s=arc-20160816;
        b=pA6D2N/u+erapzou9F58xhkDquckyQs++nT1GEMcJx4q2ABjBLpXBYw0Ug+dPQ6N7F
         IaHDQVvEZrT+lPcbs+fyezYtJEdkfziu5Vf2ET2U7y/bKdHioISuCFDctbTs2hJsGbJt
         d9ryAc/5C67A91FbEtkx9MU/nrSF5S164LdtzA8uotQGB7HYo2wcR4D2mUu7i/8e5tVm
         KnchbMSUQau7mxvoFGwWdIyMNGGyqE+LkuhMPVvqnTXev2B4iXc2X8JfGBCJbH05w7Br
         3BSQ6PZg1i5PjE4kRZF8k4E02gh8TsU5VJ9n/6oTNJ7Uv77DQvV0oYj2NNltWkdBFHWh
         T8Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/GXO6MoiLECYHjzaIi3VTdJ0AN5HOPrgDBmNYq3UnSI=;
        b=N3brrtSiOSnd6HYW49RYKVfHN5tlh6X5DriyV1J8HUSSg2yXBo2zDmhFnjQua7s55H
         uRPu8z5cupEFsyPQtTPeuFChI2s7qPZ8jCpkAlzB7pDodjC5HuS3MxGDYeiP7keCBGEt
         CgCJ8mY89aYkgfZmbDTQ3vjDWjewNJX4s6a4UnlEmcDDyseEhIDFAUo9TBmd7xq0n4lH
         GDeg9RPiiPTUvMUEZ2C+PXs3+B2jsn3Cxw3shBS3BLFk5Ai46syaNxMhamHNXkI1lksP
         KOragYnB4imVAiXwf3oklTTgBULHz63v3GJHKvnit6zstuSe+vJO46xfGt60AQlux5IL
         arAA==
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
Subject: [PATCH 4.4 011/134] perf sort: Fix segfault with basic block cycles sort dimension
Date: Mon, 19 Mar 2018 19:04:54 +0100
Message-Id: <20180319171850.727430371@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390696077368287?=
X-GMAIL-MSGID: =?utf-8?q?1595390696077368287?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -604,6 +604,9 @@ static int hist_entry__mispredict_snprin
 static int64_t
 sort__cycles_cmp(struct hist_entry *left, struct hist_entry *right)
 {
+	if (!left->branch_info || !right->branch_info)
+		return cmp_null(left->branch_info, right->branch_info);
+
 	return left->branch_info->flags.cycles -
 		right->branch_info->flags.cycles;
 }
@@ -611,6 +614,8 @@ sort__cycles_cmp(struct hist_entry *left
 static int hist_entry__cycles_snprintf(struct hist_entry *he, char *bf,
 				    size_t size, unsigned int width)
 {
+	if (!he->branch_info)
+		return scnprintf(bf, size, "%-.*s", width, "N/A");
 	if (he->branch_info->flags.cycles == 0)
 		return repsep_snprintf(bf, size, "%-*s", width, "-");
 	return repsep_snprintf(bf, size, "%-*hd", width,
