Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD68CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AA7223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="YgGVBir4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AA7223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbeKNHBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 02:01:25 -0500
Received: from alln-iport-6.cisco.com ([173.37.142.93]:39539 "EHLO
        alln-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNHBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 02:01:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3096; q=dns/txt; s=iport;
  t=1542142888; x=1543352488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kyRjHx5mYTu5pImYMjGBwrhVEf1Td1jzhmC2oc7cZjo=;
  b=YgGVBir4zJXL2GDv4yJIkZw3oQUqnkiXJGOXaz6UFzH5n4Ab1c0iYgCJ
   fcsZPyxZ1L2dCkuPoXWR7wfrD9yCjFPmwNJ/mb+7uP0+p2FVT+De07vtz
   Ulli/57o8PZ+5LVNhuD4eMUGGnvY8GvgHVcqS1kqP/Bx7rqyZRpFJKhfu
   g=;
X-IronPort-AV: E=Sophos;i="5.56,229,1539648000"; 
   d="scan'208";a="200773530"
Received: from alln-core-11.cisco.com ([173.36.13.133])
  by alln-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 21:01:27 +0000
Received: from zorba ([10.24.107.234])
        by alln-core-11.cisco.com (8.15.2/8.15.2) with ESMTPS id wADL1PXk030277
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 13 Nov 2018 21:01:26 GMT
Date:   Tue, 13 Nov 2018 13:01:26 -0800
From:   Daniel Walker <danielwa@cisco.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     "Nikunj Kela (nkela)" <nkela@cisco.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        "linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
Subject: Re: [PATCH] jffs2: implement mount option to configure endianness
Message-ID: <20181113210126.7cupw5gt3vpnyotq@zorba>
References: <591D4732-BC3E-4F85-9277-25E049FFF4BA@cisco.com>
 <CAFLxGvz8QgK1P6d-_biSRk4fyYEobio315_tUP+cRXTvt+m1hA@mail.gmail.com>
 <01b82f6eb37b674effc6c8b0fa4a014deb401a85.camel@infradead.org>
 <B1D7CC34-C9D3-4745-94A1-3F713C1CB216@cisco.com>
 <897867ec09af82ca76c642b48ad23a7f08838dcf.camel@infradead.org>
 <20181112214333.lplffcc722hta43v@zorba>
 <20181112225015.jyuro3z3ygavnvrp@zorba>
 <f64aa222a15467dc667deb5fc1bbcae1e477482a.camel@infradead.org>
 <20181112234022.r3gyu633ln3bp774@zorba>
 <b797e897960c3c047dfc7874615358a5443038a8.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b797e897960c3c047dfc7874615358a5443038a8.camel@infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.107.234, [10.24.107.234]
X-Outbound-Node: alln-core-11.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 03:43:37PM -0800, David Woodhouse wrote:
> 
> That can't hurt. We should probably look at the time elapsed before you
> can *write* to it (when the background scan and crc checking is
> complete) rather than just reading.
> 


Here are more data points. This is again with 100meg mtdram size. I made a 
script which does the mount and umount, then perf ran that 100 times over and
averaged the results.

Baseline,

 Performance counter stats for 'bash test.sh' (100 runs):

        111.414863 task-clock                #    0.637 CPUs utilized            ( +-  0.07% )
                41 context-switches          #    0.371 K/sec                    ( +-  0.50% )
                 3 cpu-migrations            #    0.023 K/sec                    ( +-  2.44% )
               405 page-faults               #    0.004 M/sec                    ( +-  0.05% )
         147235193 cycles                    #    1.322 GHz                      ( +-  0.47% ) [53.76%]
          53688988 stalled-cycles-frontend   #   36.46% frontend cycles idle     ( +-  2.59% ) [45.13%]
          21691444 stalled-cycles-backend    #   14.73% backend  cycles idle     ( +-  5.81% ) [68.50%]
         138433181 instructions              #    0.94  insns per cycle
                                             #    0.39  stalled cycles per insn  ( +-  0.88% ) [88.11%]
          25882823 branches                  #  232.310 M/sec                    ( +-  1.42% ) [85.33%]
            644457 branch-misses             #    2.49% of all branches          ( +-  5.19% ) [74.30%]

       0.175012976 seconds time elapsed                                          ( +-  0.58% )


With Nikunj's patch,


 Performance counter stats for 'bash test.sh' (100 runs):

        110.436715 task-clock                #    0.625 CPUs utilized            ( +-  0.07% )
                41 context-switches          #    0.373 K/sec                    ( +-  0.58% )
                 3 cpu-migrations            #    0.024 K/sec                    ( +-  2.18% )
               405 page-faults               #    0.004 M/sec                    ( +-  0.05% )
         145964351 cycles                    #    1.322 GHz                      ( +-  0.49% ) [53.68%]
          47504491 stalled-cycles-frontend   #   32.55% frontend cycles idle     ( +-  2.96% ) [55.47%]
          20481138 stalled-cycles-backend    #   14.03% backend  cycles idle     ( +-  6.18% ) [71.19%]
         134947645 instructions              #    0.92  insns per cycle
                                             #    0.35  stalled cycles per insn  ( +-  1.18% ) [82.19%]
          25343960 branches                  #  229.489 M/sec                    ( +-  1.65% ) [82.50%]
            693642 branch-misses             #    2.74% of all branches          ( +-  5.29% ) [70.06%]

       0.176606850 seconds time elapsed                                          ( +-  0.50% )



This seems to show an 0.91% speed elapsed time difference. Most of the rest of it seems very similar.


Daniel
