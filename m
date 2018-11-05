Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E8AECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707E2204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707E2204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbeKEQRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 11:17:04 -0500
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:62692 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728955AbeKEQRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 11:17:04 -0500
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id wA56webu007013;
        Mon, 5 Nov 2018 14:58:40 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 5 Nov 2018
 14:58:10 +0800
Date:   Mon, 5 Nov 2018 14:58:07 +0800
From:   Vincent Chen <vincentc@andestech.com>
To:     <palmer@sifive.com>, <aou@eecs.berkeley.edu>
CC:     <arnd@arndb.de>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <greentime@andestech.com>,
        <alankao@andestech.com>, <vincentc@andestech.com>,
        <zong@andestech.com>, <deanbo422@gmail.com>, <kito@andestech.com>
Subject: Re: [RFC 0/2] RISC-V: A proposal to add vendor-specific code
Message-ID: <20181105065807.GA1286@andestech.com>
References: <CAAhSdy0Y_jdc=2Lf8epof_+7HigCfhDxMNe8EF0fHfncqhs-zA@mail.gmail.com>
 <mhng-01f0ac6a-c2fd-41be-9d53-44d1c139d453@palmer-si-x1c4>
 <20181101174857.du2zu4vnrhpu5asf@excalibur.cnev.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181101174857.du2zu4vnrhpu5asf@excalibur.cnev.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com wA56webu007013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 01:48:57AM +0800, Karsten Merker wrote:
> On Wed, Oct 31, 2018 at 10:27:05AM -0700, Palmer Dabbelt wrote:
> > On Wed, 31 Oct 2018 04:16:10 PDT (-0700), anup@brainfault.org wrote:
> > > On Wed, Oct 31, 2018 at 4:06 PM Vincent Chen <vincentc@andestech.com> wrote:
> > > > 
> > > >   RISC-V permits each vendor to develop respective extension ISA based
> > > > on RISC-V standard ISA. This means that these vendor-specific features
> > > > may be compatible to their compiler and CPU. Therefore, each vendor may
> > > > be considered a sub-architecture of RISC-V. Currently, vendors do not
> > > > have the appropriate examples to add these specific features to the
> > > > kernel. In this RFC set, we propose an infrastructure that vendor can
> > > > easily hook their specific features into kernel. The first commit is
> > > > the main body of this infrastructure. In the second commit, we provide
> > > > a solution that allows dma_map_ops() to work without cache coherent
> > > > agent support. Cache coherent agent is unsupported for low-end CPUs in
> > > > the AndeStar RISC-V series. In order for Linux to run on these CPUs, we
> > > > need this solution to overcome the limitation of cache coherent agent
> > > > support. Hence, it also can be used as an example for the first commit.
> > > > 
> > > >   I am glad to discuss any ideas, so if you have any idea, please give
> > > > me some feedback.
> > > > 
> > > I agree that we need a place for vendor-specific ISA extensions and
> > > having vendor-specific directories is also good.
> > > 
> > > What I don't support is the approach of having compile time selection
> > > of vendor-specific ISA extension.
> > > 
> > > We should have runtime probing for compatible vendor-specific ISA
> > > extension. Also, it should be possible to link multiple vendor-specific
> > > SA extensions to same kernel image. This way we can have a single
> > > kernel image (along with various vendor-specific ISA extensions) which
> > > works on variety of targets/hosts.
> > > 
> > > As an example or runtime probing you can look at how IRQCHIP or
> > > CLOCKSOURCE drivers are probed. The vendor-specific ISA extension
> > > hooks should called in similar fashion.
> > 
> > Yes, I agree.  My biggest concern here is that we ensure that
> > one kernel can boot on implementations from all vendors.  I
> > haven't had a chance to look at the patches yet, but it should
> > be possible to:
> > 
> > * Build a kernel that has vendor-specific code from multiple vendors.
> > * Detect the implementation an run time and select the correct extra
> >   code.
> 
> From a distro point of view we definitely want to have one kernel
> image that is bootable everywhere.  Debian won't support any
> platform that requires a per-platform or per-vendor kernel, and I
> assume that the same will be true for Fedora and Suse.
> 
> One thing that I have stumbled upon while looking at the patches
> is that they seem to assume that X-type ISA extensions are
> strictly per vendor.  Although that is probably true in the
> majority of cases, it doesn't necessarily have to be - I could
> e.g. imagine that the DSP extensions from the PULP cores might
> be used by multiple vendors.  If such an extension would have
> state that needs to be saved on context switch, it would need
> corresponding kernel support.  Using "PULP" (or any other
> open-source project) as the vendor in such a case leads to
> another potential issue: the patches base everything on a JEDEC
> vendor ID that is compared to the contents of the mvendorid CSR,
> but such a JEDEC vendor ID usually doesn't exist for open-source
> implementations; the majority of those have mvendorid set to
> zero.
>
Many thanks for kinds of comments. I quickly synthesize the comments and
list them as below.
1. The kernel image shall include all vendor-specific code.
2. This kernel image can only enable particular vendor-specific features
   based on the CPU vendor in the running platform.
   - The runtime probing mechanism can refer to arm32/arm64, powerpc,
     IRQCHIP driver or CLOCKSOURCE driver
   - For some cases, such as open-source projects, using CSR $mvendorid
     to identify the compatibility is not appropriate.
I think the above requirements are reasonable, but I have questions about
the first requirement in practice. As far as I know, vendors are allowed
to add specific instructions and CSRs which are incompatible with other
vendors to their own ISA extensions. If I understand the first requirement
correctly, it implies that we need a "super" RISC-V toolchain. This "super"
RISC-V toolchain should recognize all kinds of vendor-specific instructions
and CSRs, so that it can compile vendor sources into objects successfully;
then it should recognize all kinds of vendor-specific relocations, so that
it can link the objects successfully. Each of them is not trivial at the
time of this proposal and in foreseeable future.

If it will take a long time to complete this "super" toolchain, I suppose
the infrastructure in this RFC might be a temporary solution before it is
ready. This scheme does not suffer the compilation problems caused by the
lack of the super toolchain because the selection of vendor-specific ISA
extension is determined at compile time. In addition, the mechanism for
checking compatibility at runtime ensures that the kernel with
vendor-specific feature runs on CPUs of other vendors just like pure
RISC-V kernel. In other words, this scheme, to some extent, satisfies the
requirements that one kernel image is bootable everywhere.

Regards,
Vincent
