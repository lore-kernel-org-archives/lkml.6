Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3949C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFD92241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="iUCgkp8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFD92241E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbeKMIpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:45:32 -0500
Received: from rcdn-iport-1.cisco.com ([173.37.86.72]:22564 "EHLO
        rcdn-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeKMIpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:45:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4033; q=dns/txt; s=iport;
  t=1542063018; x=1543272618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sGEiZfakvkWg8q9AwIiNNGa5++DUzv8jLA35ZPxRBZQ=;
  b=iUCgkp8IZmCxsMcNYgCVFClAXexZO1pgb/XvlFEHi9oT2tSN1NRLXvGO
   dYhMszVACaK4KYqlZ+PQBO0ATVf0VdrAZeiETHMbDa57l6fzip2W+xZAt
   G2vB6VsWANPjq3Q1hQlnuuGw1Z3Lu2X1zt3JcPKF2I5Ysr7B2FymuaVM1
   A=;
X-IronPort-AV: E=Sophos;i="5.54,497,1534809600"; 
   d="scan'208";a="480566188"
Received: from rcdn-core-7.cisco.com ([173.37.93.143])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2018 22:50:17 +0000
Received: from zorba ([10.154.176.235])
        by rcdn-core-7.cisco.com (8.15.2/8.15.2) with ESMTPS id wACMoGcr009837
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 12 Nov 2018 22:50:17 GMT
Date:   Mon, 12 Nov 2018 14:50:15 -0800
From:   Daniel Walker <danielwa@cisco.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     "Nikunj Kela (nkela)" <nkela@cisco.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        "linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
Subject: Re: [PATCH] jffs2: implement mount option to configure endianness
Message-ID: <20181112225015.jyuro3z3ygavnvrp@zorba>
References: <20181106214928.40020-1-nkela@cisco.com>
 <921b0f78cf67d7307a0555e1fd6f2c2976310adc.camel@infradead.org>
 <591D4732-BC3E-4F85-9277-25E049FFF4BA@cisco.com>
 <CAFLxGvz8QgK1P6d-_biSRk4fyYEobio315_tUP+cRXTvt+m1hA@mail.gmail.com>
 <01b82f6eb37b674effc6c8b0fa4a014deb401a85.camel@infradead.org>
 <B1D7CC34-C9D3-4745-94A1-3F713C1CB216@cisco.com>
 <897867ec09af82ca76c642b48ad23a7f08838dcf.camel@infradead.org>
 <20181112214333.lplffcc722hta43v@zorba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112214333.lplffcc722hta43v@zorba>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.154.176.235, [10.154.176.235]
X-Outbound-Node: rcdn-core-7.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 01:43:33PM -0800, Daniel Walker wrote:
> On Thu, Nov 08, 2018 at 07:47:08PM +0000, David Woodhouse wrote:
> > On Thu, 2018-11-08 at 18:01 +0000, Nikunj Kela (nkela) wrote:
> > >     But we can hypothesise and handwave about it until the cows come home;
> > >     I'd like to see a real test of whether it actually makes a difference
> > >     that we care about.
> > >     
> > >     If it does, one option might be to just build separate versions of
> > >     scan.c for each endianness, since that's the critical path we care
> > >     about.
> > > 
> > > I wonder if this feature is really that important that we need to duplicate the drivers.
> > > Also, it might take some time for me to find some device that I can run the tests with and without this patch.
> > 
> > Hm?
> > 
> > # modprobe mtdram size=16384
> > # mount -tjffs2 mtd0 /mnt
> > # cp -av .git /mnt # until it fills up
> > # umount /mnt
> > # perf record mount -tjffs2 mtd0 /mnt
> > 
> > On my desktop 'perf' only gets about 12 samples from that, so it's not
> > ideal. But you can make the mtdram device bigger, use something other
> > than my shiny new laptop, and use a higher sample frequency from 'perf'
> > and you should be able to get some vaguely meaningful results.
> > 
> 

Made a little mistake. The first tests were with Nikunj's very first version
which was just a pure Kconfig option. I reran the test of the second version and
increased the mtdram space to 100megs.

baseline below,

sh-4.2# perf stat -B mount -t jffs2 /dev/mtdblock7 /mnt
jffs2: Flash size not aligned to erasesize, reducing to 99944KiB

 Performance counter stats for 'mount -t jffs2 /dev/mtdblock7 /mnt':

        100.303072 task-clock                #    0.775 CPUs utilized          
                19 context-switches          #    0.189 K/sec                  
                 0 cpu-migrations            #    0.000 K/sec                  
                94 page-faults               #    0.937 K/sec                  
         134135872 cycles                    #    1.337 GHz                     [92.88%]
          29217497 stalled-cycles-frontend   #   21.78% frontend cycles idle    [92.02%]
          10493221 stalled-cycles-backend    #    7.82% backend  cycles idle    [92.05%]
         136740541 instructions              #    1.02  insns per cycle        
                                             #    0.21  stalled cycles per insn [92.04%]
          14639149 branches                  #  145.949 M/sec                   [19.06%]
           1384856 branch-misses             #    9.46% of all branches         [16.29%]

       0.129377322 seconds time elapsed


This is with the mount option changes added.


sh-4.2# perf stat -B mount -t jffs2 /dev/mtdblock7 /mnt
jffs2: Flash size not aligned to erasesize, reducing to 99944KiB

 Performance counter stats for 'mount -t jffs2 /dev/mtdblock7 /mnt':

        100.516160 task-clock                #    0.315 CPUs utilized          
                14 context-switches          #    0.139 K/sec                  
                 0 cpu-migrations            #    0.000 K/sec                  
                94 page-faults               #    0.935 K/sec                  
         129255757 cycles                    #    1.286 GHz                     [19.32%]
          26930446 stalled-cycles-frontend   #   20.84% frontend cycles idle    [92.00%]
          10068627 stalled-cycles-backend    #    7.79% backend  cycles idle    [92.05%]
         138000320 instructions              #    1.07  insns per cycle        
                                             #    0.20  stalled cycles per insn [92.04%]
          26158985 branches                  #  260.247 M/sec                   [90.09%]
           1242606 branch-misses             #    4.75% of all branches         [19.24%]

       0.319593555 seconds time elapsed


It looks like the took slightly more than twice as long to mount.

Daniel
