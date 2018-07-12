Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35A5ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727B8208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727B8208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbeGLUOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:14:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732298AbeGLUOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:14:40 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6CJwiJK064252
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 16:03:35 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k69y8980r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 16:03:34 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 12 Jul 2018 21:03:32 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Jul 2018 21:03:27 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6CK3Q4t26869994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Jul 2018 20:03:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 525D1A405D;
        Thu, 12 Jul 2018 23:03:47 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 631DDA4059;
        Thu, 12 Jul 2018 23:03:45 +0100 (BST)
Received: from localhost.localdomain (unknown [9.80.98.31])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Jul 2018 23:03:45 +0100 (BST)
Subject: Re: [PATCH v5 7/8] ima: based on policy warn about loading firmware
 (pre-allocated buffer)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Kees Cook <keescook@chromium.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Thu, 12 Jul 2018 16:03:13 -0400
In-Reply-To: <CAKv+Gu_C0H9LoqeC3PkKhaKr0TQys=1TcYFNG-JUivnN_YgBKQ@mail.gmail.com>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1530542283-26145-8-git-send-email-zohar@linux.vnet.ibm.com>
         <CAKv+Gu-nky1yX59TL2FNQ-0q7Sy399t2WpVWSy7jqYpQY4Fxjw@mail.gmail.com>
         <1531165294.3332.40.camel@linux.ibm.com>
         <CAKv+Gu-knHeBRGqo+2pb3X9cCjwovEykoXUf=DZyP7aJpoS60A@mail.gmail.com>
         <CAKv+Gu8qjzh_Tta=n9C+cfXO29e_5RcLqfQSpvR5r7QmqzHbEg@mail.gmail.com>
         <20180710191951.GF1731@minitux>
         <CAKv+Gu_C0H9LoqeC3PkKhaKr0TQys=1TcYFNG-JUivnN_YgBKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18071220-0016-0000-0000-000001E634D8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071220-0017-0000-0000-0000323ACB02
Message-Id: <1531425793.3568.275.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-12_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807120210
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-11 at 08:24 +0200, Ard Biesheuvel wrote:
> On 10 July 2018 at 21:19, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:

> > Tbh the only case I can think of where there would be a "race condition"
> > here is if we have a device that is polling the last byte of a
> > predefined firmware memory area for the firmware loader to read some
> > specific data into it. In cases where the firmware request is followed
> > by some explicit signalling to the device (or a power on sequence) I'm
> > unable to see the issue discussed here.
> >
> 
> I agree. But the latter part is platform specific, and so it requires
> some degree of trust in the driver author on the part of the IMA
> routines that request_firmware() is called at an appropriate time.

Exactly.  Qualcomm could be using the pre-allocated buffer
appropriately, but that doesn't guarantee how it will be used in the
future.

> The point I am trying to make in this thread is that there are cases
> where it makes no sense for the kernel to reason about these things,
> given that higher privilege levels such as the TrustZone secure world
> own the kernel's execution context entirely already, and given that
> masters that are not behind an IOMMU can read and write all of memory
> all of the time anyway.

> The bottom line is that reality does not respect the layering that IMA
> assumes, and so the only meaningful way to treat some of the use cases
> is simply to ignore them entirely. So we should still perform all the
> checks, but we will have to live with the limited utility of doing so
> in some scenarios (and not print nasty warnings to the kernel log for
> such cases)

You have convinced me that the warning shouldn't be emitted in either
the non IOMMU or in the IOMMU case, assuming the buffer has not been
DMA mapped.

The remaining concern is using the same buffer mapped to multiple
devices or re-using the same buffer to load multiple firmware blobs.
I'm not sure how easy that would be to detect.

I need to stage the rest of the patch set to be upstreamed.  Could we
just add a comment in the code reflecting this discussion?

Mimi

