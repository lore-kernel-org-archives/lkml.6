Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946DDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB3C2245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="OtiI+ntU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB3C2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbeKMJft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 04:35:49 -0500
Received: from alln-iport-1.cisco.com ([173.37.142.88]:45124 "EHLO
        alln-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbeKMJfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 04:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2058; q=dns/txt; s=iport;
  t=1542066025; x=1543275625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aSBVp1mK2K+ullOAq6OXb2Y3+gKsAh9Wx4ezR8Ats2I=;
  b=OtiI+ntUmbVvMXrs8WfJDU1vLuh+WnPgRGm9ODvr2CpGEMigZwsy8mxl
   J7B4Ec8DWEgXvzDW0ipN9Eniv6mHRN20yVJ+yGE0VCd1dsv/A/B9/eYNz
   Ck7Nm3dphro2r+Eno081wOgMAIUNCWIhfEJJEcWW2B5lZ09fh+8u7l9ps
   8=;
X-IronPort-AV: E=Sophos;i="5.54,497,1534809600"; 
   d="scan'208";a="200792258"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by alln-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2018 23:40:25 +0000
Received: from zorba ([10.156.154.32])
        by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTPS id wACNeNO7010137
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 12 Nov 2018 23:40:24 GMT
Date:   Mon, 12 Nov 2018 15:40:22 -0800
From:   Daniel Walker <danielwa@cisco.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     "Nikunj Kela (nkela)" <nkela@cisco.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        "linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
Subject: Re: [PATCH] jffs2: implement mount option to configure endianness
Message-ID: <20181112234022.r3gyu633ln3bp774@zorba>
References: <20181106214928.40020-1-nkela@cisco.com>
 <921b0f78cf67d7307a0555e1fd6f2c2976310adc.camel@infradead.org>
 <591D4732-BC3E-4F85-9277-25E049FFF4BA@cisco.com>
 <CAFLxGvz8QgK1P6d-_biSRk4fyYEobio315_tUP+cRXTvt+m1hA@mail.gmail.com>
 <01b82f6eb37b674effc6c8b0fa4a014deb401a85.camel@infradead.org>
 <B1D7CC34-C9D3-4745-94A1-3F713C1CB216@cisco.com>
 <897867ec09af82ca76c642b48ad23a7f08838dcf.camel@infradead.org>
 <20181112214333.lplffcc722hta43v@zorba>
 <20181112225015.jyuro3z3ygavnvrp@zorba>
 <f64aa222a15467dc667deb5fc1bbcae1e477482a.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f64aa222a15467dc667deb5fc1bbcae1e477482a.camel@infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.156.154.32, [10.156.154.32]
X-Outbound-Node: rcdn-core-8.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 03:11:32PM -0800, David Woodhouse wrote:
> On Mon, 2018-11-12 at 14:50 -0800, Daniel Walker wrote:
> >  Performance counter stats for 'mount -t jffs2 /dev/mtdblock7 /mnt':
> 
> Hm, how many decades will it take for the 'mtdblock' thing to die?
> JFFS2 doesn't use block devices :)

mount wouldn't mount unless I use it. It complained "not a block device."

sh-4.2# mount -t jffs2 /dev/mtd7 /mnt
mount:  /dev/mtd7 is not a block device

> > It looks like the took slightly more than twice as long to mount.
> 
> Assuming that's repeatable, it seems moderately suboptimal.

I don't understand how the cycles are lower, but the time is longer. I suppose
it could be measuring the time including when another process was running and
mount as waiting.. 

Looks like it's not repeatable .. Another run and the time is similar to the
baseline.

sh-4.2# perf stat -B mount -t jffs2 /dev/mtdblock7 /mnt
jffs2: Flash size not aligned to erasesize, reducing to 99944KiB

 Performance counter stats for 'mount -t jffs2 /dev/mtdblock7 /mnt':

        100.468768 task-clock                #    0.750 CPUs utilized
                14 context-switches          #    0.139 K/sec
                 0 cpu-migrations            #    0.000 K/sec
                94 page-faults               #    0.936 K/sec
         132105969 cycles                    #    1.315 GHz                     [94.26%]
          27915494 stalled-cycles-frontend   #   21.13% frontend cycles idle    [91.88%]
          10214813 stalled-cycles-backend    #    7.73% backend  cycles idle    [92.04%]
         137814560 instructions              #    1.04  insns per cycle
                                             #    0.20  stalled cycles per insn [92.04%]
          15395620 branches                  #  153.238 M/sec                   [19.29%]
           1240507 branch-misses             #    8.06% of all branches         [17.87%]

       0.133987804 seconds time elapsed



Should I test increasing the mtdram size ?

Daniel
