Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F866C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 22:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9208269E9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 22:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CsLwgfbi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9208269E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933595AbeFZW1p (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 18:27:45 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57930 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752984AbeFZW1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 18:27:44 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QMPHvp010171;
        Tue, 26 Jun 2018 15:27:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=nQ3r02xpssT8S3aXb8qjm3X8bMR8dwnJl2ytARqMQQc=;
 b=CsLwgfbij+smIEmmbv7FXi+PEAn22p4RnTId9Sw5qX640CE6ogL3PPnSh2EE0QCUQIJT
 0k0OTx46FY7fuTxXiG7fN82nWy8t4/niI0I5Alh3i8fzMv92bni/qY4cl2BlpuHq8uWT
 dZ5CyNPgC2vcEFM6ajUlDBkrdx2NZCJ2UxE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2juvreg8bv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 26 Jun 2018 15:27:22 -0700
Received: from kafai-mbp.dhcp.thefacebook.com (192.168.52.123) by
 mail.thefacebook.com (192.168.16.15) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 26 Jun 2018 15:27:10 -0700
Date:   Tue, 26 Jun 2018 15:27:09 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     Okash Khawaja <osk@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        "Alexei Starovoitov" <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180626222709.fsznwqauxojhhx7v@kafai-mbp.dhcp.thefacebook.com>
References: <20180621172523.6cd00ed1@cakuba.netronome.com>
 <20180622012052.htkvholi674x6i4f@kafai-mbp.dhcp.thefacebook.com>
 <20180622114032.162b2a76@cakuba.netronome.com>
 <20180622205535.c6vjhdwt5er4wc32@kafai-mbp.dhcp.thefacebook.com>
 <20180622142743.2b890d0f@cakuba.netronome.com>
 <20180622225408.jor7lpvsksnwiiec@kafai-mbp.dhcp.thefacebook.com>
 <20180622163200.20564ec4@cakuba.netronome.com>
 <20180623002639.h4qxy7aakypi6t7b@kafai-mbp.dhcp.thefacebook.com>
 <20180626164820.GA12981@w1t1fb>
 <20180626133133.618af1d3@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180626133133.618af1d3@cakuba.netronome.com>
User-Agent: NeoMutt/20180512
X-Originating-IP: [192.168.52.123]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 01:31:33PM -0700, Jakub Kicinski wrote:
> On Tue, 26 Jun 2018 17:48:22 +0100, Okash Khawaja wrote:
> > On Fri, Jun 22, 2018 at 05:26:39PM -0700, Martin KaFai Lau wrote:
> > > On Fri, Jun 22, 2018 at 04:32:00PM -0700, Jakub Kicinski wrote:  
> > > > On Fri, 22 Jun 2018 15:54:08 -0700, Martin KaFai Lau wrote:  
> > > > > > > > > > > > > >         "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
> > > > > > > > > > > > > >         ],
> > > > > > > > > > > > > > 	"value_struct":{
> > > > > > > > > > > > > > 		"src_ip":2,        
> > > > > > > > > If for the same map the user changes the "src_ip" to an array of int[4]
> > > > > > > > > later (e.g. to support ipv6), it will become "src_ip": [1, 2, 3, 4].
> > > > > > > > > Is it breaking backward compat?
> > > > > > > > > i.e.
> > > > > > > > > struct five_tuples {
> > > > > > > > > -	int src_ip;
> > > > > > > > > +	int src_ip[4];
> > > > > > > > > /* ... */
> > > > > > > > > };      
> > > > > > > > 
> > > > > > > > Well, it is breaking backward compat, but it's the program doing it,
> > > > > > > > not bpftool :)  BTF changes so does the output.      
> > > > > > > As we see, the key/value's btf-output is inherently not backward compat.
> > > > > > > Hence, "-j" and "-p" will stay as is.  The whole existing json will
> > > > > > > be backward compat instead of only partly backward compat.    
> > > > > > 
> > > > > > No.  There is a difference between user of a facility changing their
> > > > > > input and kernel/libraries providing different output in response to
> > > > > > that, and the libraries suddenly changing the output on their own.
> > > > > > 
> > > > > > Your example is like saying if user started using IPv6 addresses
> > > > > > instead of IPv4 the netlink attributes in dumps will be different so
> > > > > > kernel didn't keep backwards compat.  While what you're doing is more
> > > > > > equivalent to dropping support for old ioctl interfaces because there
> > > > > > is a better mechanism now.    
> > > > > Sorry, I don't follow this.  I don't see netlink suffer json issue like
> > > > > the one on "key" and "value".
> > > > > 
> > > > > All I can grasp is, the json should normally be backward compat but now
> > > > > we are saying anything added by btf-output is an exception because
> > > > > the script parsing it will treat it differently than "key" and "value"  
> > > > 
> > > > Backward compatibility means that if I run *the same* program against
> > > > different kernels/libraries it continues to work.  If someone decides
> > > > to upgrade their program to work with IPv6 (which was your example)
> > > > obviously there is no way system as a whole will look 1:1 the same.
> > > >   
> > > > > > BTF in JSON is very useful, and will help people who writes simple
> > > > > > orchestration/scripts based on bpftool *a* *lot*.  I really appreciate    
> > > > > Can you share what the script will do?  I want to understand why
> > > > > it cannot directly use the BTF format and the map data.  
> > > > 
> > > > Think about a python script which wants to read a counter in a map.
> > > > Right now it would have to get the BTF, find out which bytes are the
> > > > counter, then convert the bytes into a larger int.  With JSON BTF if
> > > > just does entry["formatted"]["value"]["counter"].
> > > > 
> > > > Real life example from my test code (conversion of 3 element counter
> > > > array):
> > > > 
> > > > def str2int(strtab):
> > > >     inttab = []
> > > >     for i in strtab:
> > > >         inttab.append(int(i, 16))
> > > >     ba = bytearray(inttab)
> > > >     if len(strtab) == 4:
> > > >         fmt = "I"
> > > >     elif len(strtab) == 8:
> > > >         fmt = "Q"
> > > >     else:
> > > >         raise Exception("String array of len %d can't be unpacked to an int" %
> > > >                         (len(strtab)))
> > > >     return struct.unpack(fmt, ba)[0]
> > > > 
> > > > def convert(elems, idx):
> > > >     val = []
> > > >     for i in range(3):
> > > >         part = elems[idx]["value"][i * length:(i + 1) * length]
> > > >         val.append(str2int(part))
> > > >     return val
> > > > 
> > > > With BTF it would be:
> > > > 
> > > > 	elems[idx]["formatted"]["value"]
> > > > 
> > > > Which is fairly awesome.  
> > > Thanks for the example.  Agree that with BTF, things are easier in general.
> > > 
> > > btw, what more awesome is,  
> > > #> bpftool map find id 100 key 1  
> > > {
> > > 	"counter_x": 1,
> > > 	"counter_y": 10
> > > }
> > >   
> > > >   
> > > > > > this addition to bpftool and will start using it myself as soon as it
> > > > > > lands.  I'm not sure why the reluctance to slightly change the output
> > > > > > format?    
> > > > > The initial change argument is because the json has to be backward compat.
> > > > > 
> > > > > Then we show that btf-output is inherently not backward compat, so
> > > > > printing it in json does not make sense at all.
> > > > > 
> > > > > However, now it is saying part of it does not have to be backward compat.  
> > > > 
> > > > Compatibility of "formatted" member is defined as -> fields broken out
> > > > according to BTF.  So it is backward compatible.  The definition of
> > > > "value" member is -> an array of unfortunately formatted array of
> > > > ugly hex strings :(
> > > >   
> > > > > I am fine putting it under "formatted" for "-j" or "-p" if that is the
> > > > > case, other than the double output is still confusing.  Lets wait for
> > > > > Okash's input.
> > > > >
> > > > > At the same time, the same output will be used as the default plaintext
> > > > > output when BTF is available.  Then the plaintext BTF output
> > > > > will not be limited by the json restrictions when we want
> > > > > to improve human readability later.  Apparently, the
> > > > > improvements on plaintext will not be always applicable
> > > > > to json output.  
> > > >   
> > 
> > hi,
> > 
> > so i guess following is what we want:
> > 
> > 1. a "formatted" object nested inside -p and -j switches for bpf map
> >   dump. this will be JSON and backward compatible
> > 2. an output for humans - which is like the current output. this will
> > not be JSON. this won't have to be backward compatible. this output will
> > be shown when neither of -j and -p are supplied and btf info is
> > available.
> > 
> > i can update the patches to v2 which covers 2 above + all other comments
> > on the patchset. later we can follow up with a patch for 1.
> 
> Please do both at the same time.  I've learnt not to trust people when
> they say things like "we can follow up with xyz" :(  In my experience it
> _always_ backfires.
> 
> Implementing both outputs in one series will help you structure your
> code to best suit both of the formats up front.
hex and "formatted" are the only things missing?  As always, things
can be refactored when new use case comes up.  Lets wait for
Okash input.

Regardless, plaintext is our current use case.  Having the current
patchset in does not stop us or others from contributing other use
cases (json, "bpftool map find"...etc),  and IMO it is actually
the opposite.  Others may help us get there faster than us alone.
We should not stop making forward progress and take this patch
as hostage because "abc" and "xyz" are not done together.
