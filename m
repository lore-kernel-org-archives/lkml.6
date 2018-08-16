Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49036C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 21:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AA62147E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 21:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08AA62147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbeHQA7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 20:59:11 -0400
Received: from a3.inai.de ([88.198.85.195]:46642 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbeHQA7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 20:59:11 -0400
X-Greylist: delayed 522 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Aug 2018 20:59:09 EDT
Received: by a3.inai.de (Postfix, from userid 25121)
        id D755750BCF23; Thu, 16 Aug 2018 23:49:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id CEFEA43D27A7;
        Thu, 16 Aug 2018 23:49:38 +0200 (CEST)
Date:   Thu, 16 Aug 2018 23:49:38 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
cc:     dwarves@vger.kernel.org, Dodji Seketeli <dodji@redhat.com>,
        Linux Networking Development Mailing List 
        <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: pahole v1.12 (BTF edition)
In-Reply-To: <20180816200942.GA19939@kernel.org>
Message-ID: <nycvar.YFH.7.76.1808162328040.2839@n3.vanv.qr>
References: <20180816200942.GA19939@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 2018-08-16 22:09, Arnaldo Carvalho de Melo wrote:

>	After a long time without announces, here is pahole 1.12,
>available at:
>
>	https://fedorapeople.org/~acme/dwarves/dwarves-1.12.tar.bz2
>
>	git://git.kernel.org/pub/scm/devel/pahole/pahole.git	
>
>	Some distros haven't picked 1.11, that comes with several
>goodies, my bad for not having announced it at that time more widely,

Missing announcements can be forgiven. But there are automatic tools 
that scrape the web for updates (usually something tries to scan
the enclosing directory of the last known URL), so uploads are 
essential.
Since 1.11 was never uploaded, it did not find its way..
(One had to grab a tarball gitweb generated from the tag,
but had to know there was a 1.11, too).


Can we have signatures for the release tarballs?
(Only if you think it's worth having.)


>Please report any problems to me, I'll try and get problems fixed.

Here's one (or six):


$ cat x.cpp 
#include <utility>
struct F {
        template<typename T, typename... A> F(T &, T &&, A &&...x) { }
        F clone() const && { int q; return F(q, 3, 4); }
        int xpub() { return xprot(); }
        protected:
        int xprot() { return xpriv(); }
        private:
        int xpriv() { return 0; }
};
int z;
F f(z,2,3,4);
int main()
{
        f.xpub();
        std::move(f).clone();
}


$ g++-7 x.cpp -c -ggdb3 -Wall && pahole x.o
die__process_function: tag not supported 0x2f (template_type_parameter)!
//expected: handle type
die__process_function: tag not supported 0x4107 (GNU_template_parameter_pack)!
//expected: handle type
die__process_function: tag not supported 0x4108 (GNU_formal_parameter_pack)!
//expected: handle type
ftype__recode_dwarf_types: couldn't find 0x321 abstract_origin for 0x397 (formal_parameter)!
//expected: handle type
ftype__recode_dwarf_types: couldn't find 0x326 abstract_origin for 0x39f (formal_parameter)!
ftype__recode_dwarf_types: couldn't find 0x3e0 abstract_origin for 0x447 (formal_parameter)!
struct F {
        class F clone(const class F  *);
	//expected: "struct F clone(const struct F *&&);"

        int xpub(class F *);

protected:

        int xprot(class F *);

private:

        int xpriv(class F *);

//expected: "public:"

        void F<int, int, int>(class F *, int &, , , );
	//expected: "void F<int, int, int>(struct F *, int &, int &&, int &&, int &&);

        void F<int, int>(class F *, int &, , );
	//expected: "void F<int, int, int>(struct F *, int &, int &&, int &&);

        /* size: 1, cachelines: 0, members: 0 */
        /* last cacheline: 1 bytes */
};
