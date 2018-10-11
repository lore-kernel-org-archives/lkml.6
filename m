Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CCDC677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5C3204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5C3204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbeJKXiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:38:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726882AbeJKXiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:38:07 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9BG9doo058821
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 12:10:14 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n27wgec2w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 12:10:14 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.vnet.ibm.com>;
        Thu, 11 Oct 2018 10:10:12 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Oct 2018 10:10:08 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9BGA7rD59834534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Oct 2018 09:10:07 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9474C78063;
        Thu, 11 Oct 2018 10:10:07 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAB3E7805E;
        Thu, 11 Oct 2018 10:10:04 -0600 (MDT)
Received: from [153.66.254.194] (unknown [9.85.185.70])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 11 Oct 2018 10:10:04 -0600 (MDT)
Subject: Re: undefined behavior (-Wvarargs) in
 security/keys/trusted.c#TSS_authhmac()
From:   James Bottomley <jejb@linux.vnet.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     zohar@linux.vnet.ibm.com, dhowells@redhat.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Date:   Thu, 11 Oct 2018 09:10:03 -0700
In-Reply-To: <CAK8P3a3PjfQHKb_Chmn6RDyLV7+xE=s_AAFdt+fNshohdD7Ztw@mail.gmail.com>
References: <CAKwvOdkqtfAyDdxkac=NtfSiskiGyOhN1PPzkxBYpR_JEBTRbw@mail.gmail.com>
         <CAK8P3a3PjfQHKb_Chmn6RDyLV7+xE=s_AAFdt+fNshohdD7Ztw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101116-0016-0000-0000-0000093FBDE3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009860; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01101164; UDB=6.00569788; IPR=6.00881210;
 MB=3.00023714; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-11 16:10:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101116-0017-0000-0000-000040AAD9DC
Message-Id: <1539274203.2623.56.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-11 at 18:02 +0200, Arnd Bergmann wrote:
> On 10/10/18, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > Hello,
> > I noticed that compiling with
> > CONFIG_TCG_TPM=y
> > CONFIG_HW_RANDOM_TPM=y
> > and Clang produced the warning:
> > 
> >   CC      security/keys/trusted.o
> > security/keys/trusted.c:146:17: warning: passing an object that
> > undergoes default
> >       argument promotion to 'va_start' has undefined behavior [-
> > Wvarargs]
> >         va_start(argp, h3);
> >                        ^
> > security/keys/trusted.c:126:37: note: parameter of type 'unsigned
> > char' is declared here
> > unsigned char *h2, unsigned char h3, ...)
> >                                ^
> > 
> > Specifically, it seems that both the C90 (4.8.1.1) and C11
> > (7.16.1.4) standards explicitly call this out as undefined
> > behavior:
> > 
> > The parameter parmN is the identifier of the rightmost parameter in
> > the variable parameter list in the function definition (the one
> > just before the ...). If the parameter parmN is declared with ...
> > or with a type that is not compatible with the type that results
> > after application of the default argument promotions, the behavior
> > is undefined.
> > 
> > So if I understand my C promotion/conversion rules correctly,
> > unsigned char would be promoted to int?
> > 
> > We had a few ideas for possible fixes in:
> > https://github.com/ClangBuiltLinux/linux/issues/41
> 
> I arrived at a similar patch as the one cited there, but it broke
> again after an 'extern' declaration was added in
> include/keys/trusted.h, so that has to be patched as well now

They look either over complicated or potentially problematic.  since
this is an internal API and a char * is always legal, what's wrong with
simply swapping h2 and h3?

James

