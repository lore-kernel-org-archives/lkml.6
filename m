Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90252C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD1524976
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Q3ulYHgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD1524976
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754653AbeFVWyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:54:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44588 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754184AbeFVWyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:54:39 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5MMrEYd013975;
        Fri, 22 Jun 2018 15:54:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=kzXD4/3Cx/dRssndQbf0lIeWSxartvuEPx3U3WMUswo=;
 b=Q3ulYHggobj3889kvrJ9D5bU2kspO/CItf934r+Bec8WWmMWxscaFfsFNaXHUHmF2QD1
 tsnuO/ti83p0hwVoTdSvm3moGfRs1SSRiWiHjpETvPhcSNncMhxDwmLv3/HnZJtQaQW2
 8+uHOgPNvSzPaNp5hNampaXtcKVjCVcftsU= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2js6verh48-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 22 Jun 2018 15:54:18 -0700
Received: from kafai-mbp.dhcp.thefacebook.com (192.168.52.123) by
 mail.thefacebook.com (192.168.16.14) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Fri, 22 Jun 2018 15:54:11 -0700
Date:   Fri, 22 Jun 2018 15:54:08 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     Okash Khawaja <osk@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        "Alexei Starovoitov" <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180622225408.jor7lpvsksnwiiec@kafai-mbp.dhcp.thefacebook.com>
References: <20180620203703.101156292@fb.com>
 <20180621145935.41ff8974@cakuba.netronome.com>
 <20180621225117.dhrkrtmkfbeihbe4@kafai-mbp.dhcp.thefacebook.com>
 <20180621160719.2cfb4b58@cakuba.netronome.com>
 <20180621235746.dfq6kdtkogftw3ws@kafai-mbp.dhcp.thefacebook.com>
 <20180621172523.6cd00ed1@cakuba.netronome.com>
 <20180622012052.htkvholi674x6i4f@kafai-mbp.dhcp.thefacebook.com>
 <20180622114032.162b2a76@cakuba.netronome.com>
 <20180622205535.c6vjhdwt5er4wc32@kafai-mbp.dhcp.thefacebook.com>
 <20180622142743.2b890d0f@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180622142743.2b890d0f@cakuba.netronome.com>
User-Agent: NeoMutt/20180512
X-Originating-IP: [192.168.52.123]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 02:27:43PM -0700, Jakub Kicinski wrote:
> On Fri, 22 Jun 2018 13:58:52 -0700, Martin KaFai Lau wrote:
> > On Fri, Jun 22, 2018 at 11:40:32AM -0700, Jakub Kicinski wrote:
> > > On Thu, 21 Jun 2018 18:20:52 -0700, Martin KaFai Lau wrote:  
> > > > On Thu, Jun 21, 2018 at 05:25:23PM -0700, Jakub Kicinski wrote:  
> > > > > On Thu, 21 Jun 2018 16:58:15 -0700, Martin KaFai Lau wrote:    
> > > > > > On Thu, Jun 21, 2018 at 04:07:19PM -0700, Jakub Kicinski wrote:    
> > > > > > > On Thu, 21 Jun 2018 15:51:17 -0700, Martin KaFai Lau wrote:      
> > > > > > > > On Thu, Jun 21, 2018 at 02:59:35PM -0700, Jakub Kicinski wrote:      
> > > > > > > > > On Wed, 20 Jun 2018 13:30:53 -0700, Okash Khawaja wrote:        
> > > > > > > > > > $ sudo bpftool map dump -p id 14
> > > > > > > > > > [{
> > > > > > > > > >         "key": 0
> > > > > > > > > >     },{
> > > > > > > > > >         "value": {
> > > > > > > > > >             "m": 1,
> > > > > > > > > >             "n": 2,
> > > > > > > > > >             "o": "c",
> > > > > > > > > >             "p": [15,16,17,18,15,16,17,18
> > > > > > > > > >             ],
> > > > > > > > > >             "q": [[25,26,27,28,25,26,27,28
> > > > > > > > > >                 ],[35,36,37,38,35,36,37,38
> > > > > > > > > >                 ],[45,46,47,48,45,46,47,48
> > > > > > > > > >                 ],[55,56,57,58,55,56,57,58
> > > > > > > > > >                 ]
> > > > > > > > > >             ],
> > > > > > > > > >             "r": 1,
> > > > > > > > > >             "s": 0x7ffff6f70568,
> > > > > > > > > >             "t": {
> > > > > > > > > >                 "x": 5,
> > > > > > > > > >                 "y": 10
> > > > > > > > > >             },
> > > > > > > > > >             "u": 100,
> > > > > > > > > >             "v": 20,
> > > > > > > > > >             "w1": 0x7,
> > > > > > > > > >             "w2": 0x3
> > > > > > > > > >         }
> > > > > > > > > >     }
> > > > > > > > > > ]        
> > > > > > > > > 
> > > > > > > > > I don't think this format is okay, JSON output is an API you shouldn't
> > > > > > > > > break.  You can change the non-JSON output whatever way you like, but
> > > > > > > > > JSON must remain backwards compatible.
> > > > > > > > > 
> > > > > > > > > The dump today has object per entry, e.g.:
> > > > > > > > > 
> > > > > > > > > {
> > > > > > > > >         "key":["0x00","0x00","0x00","0x00",
> > > > > > > > >         ],
> > > > > > > > >         "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
> > > > > > > > >         ]
> > > > > > > > > }
> > > > > > > > > 
> > > > > > > > > This format must remain, you may only augment it with new fields.  E.g.:
> > > > > > > > > 
> > > > > > > > > {
> > > > > > > > >         "key":["0x00","0x00","0x00","0x00",
> > > > > > > > >         ],
> > > > > > > > > 	"key_struct":{
> > > > > > > > > 		"index":0
> > > > > > > > > 	},    
> > > > Got a few questions.
> > > > 
> > > > When we support hashtab later, the key could be int
> > > > but reusing the name as "index" is weird.  
> > > 
> > > Ugh, yes, naturally.  I just typed that out without thinking, so for
> > > array maps there is usually no BTF info?...  For hashes obviously we  
> > The key of array map also has BTF info which must be an int.
> 
> Perfect.
> 
> > > should just use the BTF, I'm not sure we should format indexes for
> > > arrays nicely or not :S
> > >   
> > > > The key could also be a struct (e.g. a struct to describe ip:port).
> > > > Can you suggest how the "key_struct" will look like?  
> > > 
> > > Hm.  I think in my mind it has only been a struct but that's not true :S
> > > So the struct in the name makes very limited sense now.
> > > 
> > > Should we do:
> > > "formatted" : {
> > > 	"value" : XXX
> > > }
> > > 
> > > Where
> > > XXX == plain int for integers, e.g. "value":0
> > > XXX == array for arrays, e.g. "value":[1,2,3,4]
> > > XXX == object for objects, e.g. "value":{"field":XXX, "field2":XXX}  
> > It is exactly how this patch is using json's {}, [] and int. ;)
> 
> Great, then just wrap that in a "formatted" object instead of
> redefining fields and we're good?
> 
> > but other than that, it does not have to be json.
> > In the next spin, lets stop calling this output json to avoid wrong
> > user's expection and I also don't want the future readability
> > improvements to be limited by that.  Lets call it something
> > like plain text output with BTF.
> 
> I don't understand.  We are discussing JSON output here.  The example we
> are commenting on is output of:
> 
> $ sudo bpftool map dump -p id 14
> 
> That -p means JSON.  Nobody objects to plain test output changes.  I
> actually didn't realize you haven't implemented plain text in this
> series, we should have both.
> 
> > How about:
> > When "bpftool map dump id 1" is used, it will print the BTF plaintext output
> > if a map has BTF available.  If not, it will print the existing
> > plaintext output.  That should solve the concern about the user may not
> > know BTF is available.
> > 
> > This ascii output is for human.  The script should not parse the ascii output
> > because it is silly not to use the binary ABI (like what this patch is using)
> > which does not suffer backward compat issue.
> 
> What binary ABI?  I'm also not 100% sure what this patch is doing as it
> adds bunch of code in new files that never gets called:
I meant the BTF format, the new kernel API to get BTF and how it is used
on map data are stable.

Yes, there is new codes to get and consume the new BTF format but so does
any new kernel API.  and it should not drive everybody to parse ascii.

> 
>  tools/bpf/bpftool/btf_dumper.c |  247 +++++++++++++++++++++++++++++++++++++++++
>  tools/bpf/bpftool/btf_dumper.h |   18 ++
>  2 files changed, 265 insertions(+)
> 
> > The existing "-j" can be used to dump the map's binary data
> > for remote debugging purpose.  The BTF is in one of the elf section of
> > the bpf_prog.o.
> 
> > > > > > > > >         "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
> > > > > > > > >         ],
> > > > > > > > > 	"value_struct":{
> > > > > > > > > 		"src_ip":2,    
> > > > If for the same map the user changes the "src_ip" to an array of int[4]
> > > > later (e.g. to support ipv6), it will become "src_ip": [1, 2, 3, 4].
> > > > Is it breaking backward compat?
> > > > i.e.
> > > > struct five_tuples {
> > > > -	int src_ip;
> > > > +	int src_ip[4];
> > > > /* ... */
> > > > };  
> > > 
> > > Well, it is breaking backward compat, but it's the program doing it,
> > > not bpftool :)  BTF changes so does the output.  
> > As we see, the key/value's btf-output is inherently not backward compat.
> > Hence, "-j" and "-p" will stay as is.  The whole existing json will
> > be backward compat instead of only partly backward compat.
> 
> No.  There is a difference between user of a facility changing their
> input and kernel/libraries providing different output in response to
> that, and the libraries suddenly changing the output on their own.
> 
> Your example is like saying if user started using IPv6 addresses
> instead of IPv4 the netlink attributes in dumps will be different so
> kernel didn't keep backwards compat.  While what you're doing is more
> equivalent to dropping support for old ioctl interfaces because there
> is a better mechanism now.
Sorry, I don't follow this.  I don't see netlink suffer json issue like
the one on "key" and "value".

All I can grasp is, the json should normally be backward compat but now
we are saying anything added by btf-output is an exception because
the script parsing it will treat it differently than "key" and "value"

> 
> BTF in JSON is very useful, and will help people who writes simple
> orchestration/scripts based on bpftool *a* *lot*.  I really appreciate
Can you share what the script will do?  I want to understand why
it cannot directly use the BTF format and the map data.

> this addition to bpftool and will start using it myself as soon as it
> lands.  I'm not sure why the reluctance to slightly change the output
> format?
The initial change argument is because the json has to be backward compat.

Then we show that btf-output is inherently not backward compat, so
printing it in json does not make sense at all.

However, now it is saying part of it does not have to be backward compat.

I am fine putting it under "formatted" for "-j" or "-p" if that is the
case, other than the double output is still confusing.  Lets wait for
Okash's input.

At the same time, the same output will be used as the default plaintext
output when BTF is available.  Then the plaintext BTF output
will not be limited by the json restrictions when we want
to improve human readability later.  Apparently, the
improvements on plaintext will not be always applicable
to json output.
