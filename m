Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519414060-2-13638918135289068892
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414060; b=UDKSqoecikaX5iVdByYTFO7N08yEW+nRS1rYZPtn8+8F4/z
    MlCXQzC9l0uT0e04XqcQS8iA0mk/RS8ugAOH9R6TTrGRwfLXBK8AEujpYPwsXEem
    TlVsV9+eW+t3WwAkwkEOkFSqBBOK8aNFz4bEp/qsoQg534x83+Pe4XMb+NOWYHJd
    ShLQoIV6JrR9rG3wtPUbFDpJHRDLiFhKghWpOQx/wwZxYL8irMrqHQu2/SwTkXW0
    +JqFAwwEoO3gGb5VdU7JI/LlIOASBBKkcjZub1lvkJ8uMG3dKmdQU17gB48hZGma
    FhqZylns4VWGEMzHdIgjP+mHhUjFf2ut66DxJbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414060; bh=FLxqOXJEKncgnzj21E0g8ABwQF
    CR66R9cbzNc07GFI8=; b=Ji8ZXK1L3EhKxXfCpXyMkLHxMgbiqQaXEavhEpQfMW
    FQpEVyoR96j7EGxJJBolHgs7DHp49Rnxp37YzyBnBTGGYM+9VDaNfjPzex7SFc7s
    vFoY5Hm4uVogpDX0mGLNnRGUGUMCf0FkX9E8Ue9alwyrioVcRQ3YfMLJk7iTOnkq
    rR8aZ3e7oKkwHmC7lBCiVfMmKg2iPaWHwkLh9R8WjhASAR50mEpKXIChqzCJX9pt
    GIaYBz5XwB6vCfNI9fcIz3ztLL0GM8L5Xrz2m7MwVxxaLV7BR3RZ+xucCOi8wjYY
    RZZgQ1CpyFXOd0IK0sP75hz6QsfB/mhv+OzXW6Nb7Zcg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754012AbeBWSwX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:52:23 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46876 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754173AbeBWSwV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:52:21 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 068/159] perf record: Fix -c/-F options for cpu event aliases
Date: Fri, 23 Feb 2018 19:26:16 +0100
Message-Id: <20180223170751.864174674@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Kleen <ak@linux.intel.com>


[ Upstream commit 59622fd496a3175c7bf549046e091d81c303ecff ]

The Intel PMU event aliases have a implicit period= specifier to set the
default period.

Unfortunately this breaks overriding these periods with -c or -F,
because the alias terms look like they are user specified to the
internal parser, and user specified event qualifiers override the
command line options.

Track that they are coming from aliases by adding a "weak" state to the
term. Any weak terms don't override command line options.

I only did it for -c/-F for now, I think that's the only case that's
broken currently.

Before:

$ perf record -c 1000 -vv -e uops_issued.any
...
  { sample_period, sample_freq }   2000003

After:

$ perf record -c 1000 -vv -e uops_issued.any
...
  { sample_period, sample_freq }   1000

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20171020202755.21410-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/evsel.c        |   12 ++++++++----
 tools/perf/util/evsel.h        |    1 +
 tools/perf/util/parse-events.c |    2 ++
 tools/perf/util/parse-events.h |    3 +++
 tools/perf/util/pmu.c          |    5 +++++
 5 files changed, 19 insertions(+), 4 deletions(-)

--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -733,12 +733,16 @@ static void apply_config_terms(struct pe
 	list_for_each_entry(term, config_terms, list) {
 		switch (term->type) {
 		case PERF_EVSEL__CONFIG_TERM_PERIOD:
-			attr->sample_period = term->val.period;
-			attr->freq = 0;
+			if (!(term->weak && opts->user_interval != ULLONG_MAX)) {
+				attr->sample_period = term->val.period;
+				attr->freq = 0;
+			}
 			break;
 		case PERF_EVSEL__CONFIG_TERM_FREQ:
-			attr->sample_freq = term->val.freq;
-			attr->freq = 1;
+			if (!(term->weak && opts->user_freq != UINT_MAX)) {
+				attr->sample_freq = term->val.freq;
+				attr->freq = 1;
+			}
 			break;
 		case PERF_EVSEL__CONFIG_TERM_TIME:
 			if (term->val.time)
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -67,6 +67,7 @@ struct perf_evsel_config_term {
 		bool	overwrite;
 		char	*branch;
 	} val;
+	bool weak;
 };
 
 /** struct perf_evsel - event selector
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1115,6 +1115,7 @@ do {								\
 	INIT_LIST_HEAD(&__t->list);				\
 	__t->type       = PERF_EVSEL__CONFIG_TERM_ ## __type;	\
 	__t->val.__name = __val;				\
+	__t->weak	= term->weak;				\
 	list_add_tail(&__t->list, head_terms);			\
 } while (0)
 
@@ -2395,6 +2396,7 @@ static int new_term(struct parse_events_
 
 	*term = *temp;
 	INIT_LIST_HEAD(&term->list);
+	term->weak = false;
 
 	switch (term->type_val) {
 	case PARSE_EVENTS__TERM_TYPE_NUM:
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -101,6 +101,9 @@ struct parse_events_term {
 	/* error string indexes for within parsed string */
 	int err_term;
 	int err_val;
+
+	/* Coming from implicit alias */
+	bool weak;
 };
 
 struct parse_events_error {
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -404,6 +404,11 @@ static int pmu_alias_terms(struct perf_p
 			parse_events_terms__purge(&list);
 			return ret;
 		}
+		/*
+		 * Weak terms don't override command line options,
+		 * which we don't want for implicit terms in aliases.
+		 */
+		cloned->weak = true;
 		list_add_tail(&cloned->list, &list);
 	}
 	list_splice(&list, terms);
