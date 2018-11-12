Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43D5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6792245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="nFH9W8os"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6792245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbeKMHii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 02:38:38 -0500
Received: from rcdn-iport-6.cisco.com ([173.37.86.77]:15996 "EHLO
        rcdn-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeKMHii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 02:38:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3721; q=dns/txt; s=iport;
  t=1542059015; x=1543268615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pTRoM1CeW2rWtkoLjjv/K2EdkUnA09vwhUTZGLL6Y+w=;
  b=nFH9W8osFlPJH1LwYeeX4KbxxI/C8UBoZP1oPHrK8soq9N8nNvhpIn2c
   u3O8FAnUYFonxb690nxFeLnRFWBdW6Uuc3d3TKYaOWgodSb8LL4hRNPta
   oXMPWDcWSFwTmQyfqMP/fg1RC47lyPloaGUHdL3xIfJy6ynjLsze0Sgm6
   4=;
X-IronPort-AV: E=Sophos;i="5.54,496,1534809600"; 
   d="scan'208";a="480645960"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2018 21:43:35 +0000
Received: from zorba ([10.156.154.32])
        by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTPS id wACLhXNs008677
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 12 Nov 2018 21:43:35 GMT
Date:   Mon, 12 Nov 2018 13:43:33 -0800
From:   Daniel Walker <danielwa@cisco.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     "Nikunj Kela (nkela)" <nkela@cisco.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        "linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
Subject: Re: [PATCH] jffs2: implement mount option to configure endianness
Message-ID: <20181112214333.lplffcc722hta43v@zorba>
References: <20181106214928.40020-1-nkela@cisco.com>
 <921b0f78cf67d7307a0555e1fd6f2c2976310adc.camel@infradead.org>
 <591D4732-BC3E-4F85-9277-25E049FFF4BA@cisco.com>
 <CAFLxGvz8QgK1P6d-_biSRk4fyYEobio315_tUP+cRXTvt+m1hA@mail.gmail.com>
 <01b82f6eb37b674effc6c8b0fa4a014deb401a85.camel@infradead.org>
 <B1D7CC34-C9D3-4745-94A1-3F713C1CB216@cisco.com>
 <897867ec09af82ca76c642b48ad23a7f08838dcf.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <897867ec09af82ca76c642b48ad23a7f08838dcf.camel@infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.156.154.32, [10.156.154.32]
X-Outbound-Node: rcdn-core-8.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 07:47:08PM +0000, David Woodhouse wrote:
> On Thu, 2018-11-08 at 18:01 +0000, Nikunj Kela (nkela) wrote:
> >     But we can hypothesise and handwave about it until the cows come home;
> >     I'd like to see a real test of whether it actually makes a difference
> >     that we care about.
> >     
> >     If it does, one option might be to just build separate versions of
> >     scan.c for each endianness, since that's the critical path we care
> >     about.
> > 
> > I wonder if this feature is really that important that we need to duplicate the drivers.
> > Also, it might take some time for me to find some device that I can run the tests with and without this patch.
> 
> Hm?
> 
> # modprobe mtdram size=16384
> # mount -tjffs2 mtd0 /mnt
> # cp -av .git /mnt # until it fills up
> # umount /mnt
> # perf record mount -tjffs2 mtd0 /mnt
> 
> On my desktop 'perf' only gets about 12 samples from that, so it's not
> ideal. But you can make the mtdram device bigger, use something other
> than my shiny new laptop, and use a higher sample frequency from 'perf'
> and you should be able to get some vaguely meaningful results.
> 

10 meg MTDRAM device baseline without any changes,

sh-4.2# perf stat -B  mount -tjffs2 /dev/mtdblock7 /mnt
jffs2: Flash size not aligned to erasesize, reducing to 9920KiB

 Performance counter stats for 'mount -tjffs2 /dev/mtdblock7 /mnt':

         74.922624 task-clock                #    0.820 CPUs utilized          
                14 context-switches          #    0.187 K/sec                  
                 0 cpu-migrations            #    0.000 K/sec                  
                94 page-faults               #    0.001 M/sec                  
         103274114 cycles                    #    1.378 GHz                     [ 6.65%]
           1887555 stalled-cycles-frontend   #    1.83% frontend cycles idle   
           1688520 stalled-cycles-backend    #    1.63% backend  cycles idle   
         106423876 instructions              #    1.03  insns per cycle        
                                             #    0.02  stalled cycles per insn
          21325416 branches                  #  284.633 M/sec                   [97.41%]
            104797 branch-misses             #    0.49% of all branches         [95.20%]

       0.091398368 seconds time elapsed


Same partition size, adding in the patch from Nikunj set to Native,

sh-4.2# perf stat -B mount -t jffs2 /dev/mtdblock7 /mnt
jffs2: Flash size not aligned to erasesize, reducing to 9920KiB

 Performance counter stats for 'mount -t jffs2 /dev/mtdblock7 /mnt':

         75.223488 task-clock                #    0.736 CPUs utilized          
                17 context-switches          #    0.226 K/sec                  
                 0 cpu-migrations            #    0.000 K/sec                  
                94 page-faults               #    0.001 M/sec                  
         100815917 cycles                    #    1.340 GHz                    
          16561335 stalled-cycles-frontend   #   16.43% frontend cycles idle   
           2991700 stalled-cycles-backend    #    2.97% backend  cycles idle   
         106536662 instructions              #    1.06  insns per cycle        
                                             #    0.16  stalled cycles per insn
          10931326 branches                  #  145.318 M/sec                   [ 4.13%]
            931410 branch-misses             #    8.52% of all branches         [ 2.87%]

       0.102157784 seconds time elapsed


I'm not sure this tells us very much. If anything it looks like not much has changes.

Daniel
