Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509F4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075C920834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075C920834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeH3T3Y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:29:24 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([146.101.78.211]:42945 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727117AbeH3T3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:29:24 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-65-2HtZPnJ-OzKpCULN597HVw-1; Thu, 30 Aug 2018 16:26:40 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 30 Aug 2018 16:28:18 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 30 Aug 2018 16:28:18 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'cphlipot0@gmail.com'" <cphlipot0@gmail.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "acme@kernel.org" <acme@kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] perf event-parse: Use fixed size string for comms
Thread-Topic: [PATCH] perf event-parse: Use fixed size string for comms
Thread-Index: AQHUQAhYBLgfg1wcJkWfveOQCqo6d6TYauLQ
Date:   Thu, 30 Aug 2018 15:28:18 +0000
Message-ID: <0a4dba94bdbb41929350fe5504ee24bb@AcuMS.aculab.com>
References: <20180830021950.15563-1-cphlipot0@gmail.com>
In-Reply-To: <20180830021950.15563-1-cphlipot0@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: 2HtZPnJ-OzKpCULN597HVw-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: cphlipot0@gmail.com
> Sent: 30 August 2018 03:20
> 
> Some implementations of libc do not support the 'm' width modifier
> as part of the scanf string format specifier. This can cause the
> parsing to fail.  Since the parser never checks if the scanf
> parsing was successesful, this can result in a crash.
> 
> Change the comm string to be allocated as a fixed size instead of
> dynamically using 'm' scanf width modifier. This can be safely done
> since comm size is limited to 16 bytes by TASK_COMM_LEN within the
> kernel.
> 
> This change prevents perf from crashing when linked against bionic
> as well as reduces the total number of heap allocations and frees
> invoked while accomplishing the same task.
> 
> Signed-off-by: Chris Phlipot <cphlipot0@gmail.com>
> ---
>  tools/perf/util/trace-event-parse.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
> index 920b1d58a068..e76214f8d596 100644
> --- a/tools/perf/util/trace-event-parse.c
> +++ b/tools/perf/util/trace-event-parse.c
> @@ -164,16 +164,15 @@ void parse_ftrace_printk(struct tep_handle *pevent,
>  void parse_saved_cmdline(struct tep_handle *pevent,
>  			 char *file, unsigned int size __maybe_unused)
>  {
> -	char *comm;
> +	char comm[17]; /* Max comm length in the kernel is 16. */
>  	char *line;
>  	char *next = NULL;
>  	int pid;
> 
>  	line = strtok_r(file, "\n", &next);
>  	while (line) {
> -		sscanf(line, "%d %ms", &pid, &comm);
> -		tep_register_comm(pevent, comm, pid);
> -		free(comm);
> +		if (sscanf(line, "%d %16s", &pid, comm) == 2)
> +			tep_register_comm(pevent, comm, pid);
>  		line = strtok_r(NULL, "\n", &next);

Seems to me that sscanf is the wrong tool for the job (as usual).
Why not just:
		pid = strtoul(line, &comm, 10);
		while (*comm == ' ')
			comm++;
		tep_register_comm(pevent, comm, pid);

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

