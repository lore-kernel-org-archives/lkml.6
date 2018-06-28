Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E55C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DCF278E8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10DCF278E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936016AbeF1Ugn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 16:36:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932078AbeF1Ugm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 16:36:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B41094010216;
        Thu, 28 Jun 2018 20:36:41 +0000 (UTC)
Received: from ovpn-200-28.brq.redhat.com (ovpn-200-28.brq.redhat.com [10.40.200.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 792FA111CD37;
        Thu, 28 Jun 2018 20:36:38 +0000 (UTC)
Date:   Thu, 28 Jun 2018 22:36:36 +0200 (CEST)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: saruman@Enrico
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
cc:     Kim Phillips <kim.phillips@arm.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        =?ISO-8859-15?Q?Hendrik_Br=FCckner?= <brueckner@linux.vnet.ibm.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] perf test shell: make perf inet_pton test more
 portable
In-Reply-To: <20180621151800.GU20477@kernel.org>
Message-ID: <alpine.DEB.2.20.1806262331000.29977@Enrico>
References: <20180619184952.dac6a3a1e39d3b1d255e7119@arm.com> <20180620134622.GM20477@kernel.org> <20180620194546.364cc109430ac51c5a288739@arm.com> <20180621141915.GS20477@kernel.org> <20180621151800.GU20477@kernel.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 28 Jun 2018 20:36:41 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 28 Jun 2018 20:36:41 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpetlan@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jun 21, 2018 at 11:19:15AM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Wed, Jun 20, 2018 at 07:45:46PM -0500, Kim Phillips escreveu:
>>> On Wed, 20 Jun 2018 10:46:22 -0300
>>> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
[...]
>
> Would be good if we had some utility that given a two files, one with
> regexps, could tell if, line by line, those expressions matched, better,
> one that is present in all these OSes...
>
I have struggled with this too [1], [2]. I use perl, not sure if it is
all-distro-compliant, probably not, but anyway...

To have:
  - regexps generic enough (e.g. to parse "casual perf-script output line")
  - regexps adjustable to concrete needs
  - regexps to be understandable as much as possible
  ---> I have $RE_SOMETHING, e.g. RE_LINE_REPORT_CONTENT, such as in [2],
  and some primitives which I make the more concrete regexps from, such
  as $RE_EVENT_ANY, $RE_PATH, etc. going into e.g.:
     REGEXP_STAT_LINE="^\s+$RE_NUMBER\s+$RE_EVENT_ANY\s*"

  - various utilities:
    - all output lines matched some regexp in the file
    - all regexps in the file were matched by something in the output
    - at least one of the patterns found in output
    - none of the patterns found in the output
    - ...
    ---> I had to write these and few more scripts to handle the parsing
    of perf output, as in [1], however it still is not ideal...

[1] https://github.com/rfmvh/perftool-testsuite/tree/master/common
[2] https://github.com/rfmvh/perftool-testsuite/blob/master/common/patterns.sh

Cheers,
Michael

P.S. Could anyone try whether my suite would work on the dash (or any other
"non-fedora" environment)? I haven't had problems with this so far, but
of course I haven't tried many...

> - Arnaldo
>
[...]
