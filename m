Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC7CC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1356E20936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="gnatZTnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1356E20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390012AbeGJSgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:36:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43584 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389962AbeGJSgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:36:48 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6AHEKMa007168;
        Tue, 10 Jul 2018 10:18:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=ToB/f4lsHUAnD4KHaE1CnfEuKhYO6YcFw025yBp0DvQ=;
 b=gnatZTnPeO77zNrt6bsGNghZiKXxvOdkZLLxwqLeNrpO7Z3/h+u5YZZ+PdZbufBELRfq
 ciJXLhGZx3lWJMBxVoGGpODFQ3sOqyjVay9G1SLD/pH0HCBNtC/QIQIi4IB4mz3AeQNs
 O12ro1tQjPgVjhHVizQeBez0nrBpYZneCL4= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k4x6n8yvw-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 10 Jul 2018 10:18:56 -0700
Received: from kafai-mbp.dhcp.thefacebook.com (192.168.52.123) by
 mail.thefacebook.com (192.168.16.22) with Microsoft SMTP Server (TLS) id
 14.3.319.2; Tue, 10 Jul 2018 10:18:50 -0700
Date:   Tue, 10 Jul 2018 10:18:47 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     David Laight <David.Laight@ACULAB.COM>
CC:     Okash Khawaja <osk@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        "Alexei Starovoitov" <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf 1/1] bpf: btf: Fix bitfield extraction for big endian
Message-ID: <20180710171836.xcegzammqym4sqri@kafai-mbp.dhcp.thefacebook.com>
References: <20180709002202.019053555@fb.com>
 <20180709004002.440153594@fb.com>
 <20180709183236.r4b7gzmev5h4lcbw@kafai-mbp.dhcp.thefacebook.com>
 <457ec72d8d7c4cdd8c112f9c8c91b0e7@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <457ec72d8d7c4cdd8c112f9c8c91b0e7@AcuMS.aculab.com>
User-Agent: NeoMutt/20180512
X-Originating-IP: [192.168.52.123]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-10_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 04:35:04PM +0000, David Laight wrote:
> From: Martin KaFai Lau
> > Sent: 09 July 2018 19:33
> > On Sun, Jul 08, 2018 at 05:22:03PM -0700, Okash Khawaja wrote:
> > > When extracting bitfield from a number, btf_int_bits_seq_show() builds
> > > a mask and accesses least significant byte of the number in a way
> > > specific to little-endian. This patch fixes that by checking endianness
> > > of the machine and then shifting left and right the unneeded bits.
> > >
> > > Thanks to Martin Lau for the help in navigating potential pitfalls when
> > > dealing with endianess and for the final solution.
> > >
> > > Fixes: b00b8daec828 ("bpf: btf: Add pretty print capability for data with BTF type info")
> > > Signed-off-by: Okash Khawaja <osk@fb.com>
> > >
> > > ---
> > >  kernel/bpf/btf.c |   32 +++++++++++++++-----------------
> > >  1 file changed, 15 insertions(+), 17 deletions(-)
> > >
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -162,6 +162,8 @@
> > >  #define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
> > >  #define BITS_ROUNDUP_BYTES(bits) \
> > >  	(BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
> > > +const int one = 1;
> > > +#define is_big_endian() ((*(char *)&one) == 0)
> > >
> > >  #define BTF_INFO_MASK 0x0f00ffff
> > >  #define BTF_INT_MASK 0x0fffffff
> > > @@ -991,16 +993,13 @@ static void btf_int_bits_seq_show(const
> > >  				  void *data, u8 bits_offset,
> > >  				  struct seq_file *m)
> > >  {
> > > +	u8 left_shift_bits, right_shift_bits;
> > Nit.
> > Although only max 64 bit int is allowed now (ensured by btf_int_check_meta),
> > it is better to use u16 such that it will be consistent to BTF_INT_BITS.
> 
> Double-nit.
> 
> Use 'int' or 'unsigned int'.
> Sub-word arithmetic will require extra instructions on almost everything
> except x86.
I would prefer to keep it as u16 which is the max width that is allowed for
this field in the wire format.  Keeping the usage consistent can avoid
accidentally incorrect offsetting or writing wrong data out in other
cases.
