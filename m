Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE00C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CB9208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16CB9208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeH0SOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:14:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:49358 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726953AbeH0SOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:14:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B3F5AECB;
        Mon, 27 Aug 2018 14:28:02 +0000 (UTC)
Subject: Re: [PATCH] Properly interpret indirect call in perf annotate.
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, kernel-team@lge.com
References: <bd1f3932-be2b-85f9-7582-111ee0a43b07@suse.cz>
 <20180827103715.GB8065@sejong>
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Message-ID: <3e0c89cf-3e2a-5e23-7921-123a061f3558@suse.cz>
Date:   Mon, 27 Aug 2018 16:28:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827103715.GB8065@sejong>
Content-Type: multipart/mixed;
 boundary="------------6A763E9AD35B1793E37A0A8C"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6A763E9AD35B1793E37A0A8C
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 08/27/2018 12:37 PM, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Aug 23, 2018 at 02:29:34PM +0200, Martin Liška wrote:
>> The patch changes interpretation of:
>> callq  *0x8(%rbx)
>>
>> from:
>>   0.26 │     → callq  *8
>> to:
>>   0.26 │     → callq  *0x8(%rbx)
>>
>> in this can an address is followed by a register, thus
>> one can't parse only address.
> 
> Also there's a case with no offset like:  callq  *%rbx

Yes. But this case is fine as strtoull returns 0 for that:
'If there were no digits at all, strtoul() stores the original value of nptr in *endptr (and returns 0).'
So ops->target.addr is then 0 and it's fine.

> 
> 
>>
>> Signed-off-by: Martin Liška <mliska@suse.cz>
>> ---
>>  tools/perf/util/annotate.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>>
> 
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index e4268b948e0e..e32ead4744bd 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
>> @@ -246,8 +246,14 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
>>  
>>  indirect_call:
>>  	tok = strchr(endptr, '*');
>> -	if (tok != NULL)
>> -		ops->target.addr = strtoull(tok + 1, NULL, 16);
>> +	if (tok != NULL) {
>> +		endptr++;
>> +
>> +		/* Indirect call can use a non-rip register and offset: callq  *0x8(%rbx).
>> +		 * Do not parse such instruction.  */
>> +		if (strstr(endptr, "(%r") == NULL)
>> +			ops->target.addr = strtoull(endptr, NULL, 16);
> 
> It seems too x86-specific, what about this? (not tested)

It is, I'm fine with that. I've just tested that for the callq  *0x8(%rbx) example.
I'm sending patch for that version.

Martin

> 
> 
> indirect_call:
> 	tok = strchr(endptr, '*');
> 	if (tok != NULL) {
> 		endptr++;
> 		if (!isdigit(*endptr))
> 			return 0;
> 
> 		addr = strtoull(endptr, &endptr, 0);
> 		if (*endptr != '('))
> 			ops->target.addr = addr;
> 
> 
> Thanks,
> Namhyung
> 
> 
>> +	}
>>  	goto find_target;
>>  }
>>  
>>
> 


--------------6A763E9AD35B1793E37A0A8C
Content-Type: text/x-patch;
 name="0001-Properly-interpret-indirect-call-in-perf-annotate.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0001-Properly-interpret-indirect-call-in-perf-annotate.patch"

From 58a0eca544be8cc9e15b2ab5ecd9d9401ff4d2ec Mon Sep 17 00:00:00 2001
From: marxin <mliska@suse.cz>
Date: Thu, 23 Aug 2018 14:25:33 +0200
Subject: [PATCH] Properly interpret indirect call in perf annotate.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch changes interpretation of:
callq  *0x8(%rbx)

from:
  0.26 │     → callq  *8
to:
  0.26 │     → callq  *0x8(%rbx)

in this can an address is followed by a register, thus
one can't parse only address.

Signed-off-by: Martin Liška <mliska@suse.cz>
---
 tools/perf/util/annotate.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e4268b948e0e..18a8477d4664 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -212,6 +212,7 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	struct addr_map_symbol target = {
 		.map = map,
 	};
+  u64 addr;
 
 	ops->target.addr = strtoull(ops->raw, &endptr, 16);
 
@@ -246,8 +247,15 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 
 indirect_call:
 	tok = strchr(endptr, '*');
-	if (tok != NULL)
-		ops->target.addr = strtoull(tok + 1, NULL, 16);
+	if (tok != NULL) {
+		endptr++;
+		if (!isdigit(*endptr))
+			return 0;
+
+		addr = strtoull(endptr, &endptr, 0);
+		if (*endptr != '(')
+			ops->target.addr = addr;
+	}
 	goto find_target;
 }
 
-- 
2.18.0


--------------6A763E9AD35B1793E37A0A8C--
