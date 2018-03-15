Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbeCOQUD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:20:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35544 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752131AbeCOQTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:19:19 -0400
Subject: Re: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Safford, David (GE Global Research, US)" <david.safford@ge.com>,
        Jiandi An <anjiandi@codeaurora.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Thu, 15 Mar 2018 12:19:09 -0400
In-Reply-To: <1521048306.4508.56.camel@HansenPartnership.com>
References: <1520400386-17674-1-git-send-email-anjiandi@codeaurora.org>
         <20180307185132.GA30102@ziepe.ca>
         <1520448953.10396.565.camel@linux.vnet.ibm.com>
         <1520449719.5558.28.camel@HansenPartnership.com>
         <1520450495.10396.587.camel@linux.vnet.ibm.com>
         <1520451662.24314.5.camel@HansenPartnership.com>
         <1520461156.10396.654.camel@linux.vnet.ibm.com>
         <191cfd49-0c66-a5ef-3d2b-b6c4132aa294@codeaurora.org>
         <1520615461.12216.6.camel@HansenPartnership.com>
         <1520891598.3547.190.camel@linux.vnet.ibm.com>
         <1520893847.4522.62.camel@HansenPartnership.com>
         <1520897400.3547.253.camel@linux.vnet.ibm.com>
         <1520899605.4522.67.camel@HansenPartnership.com>
         <BCA04D5D9A3B764C9B7405BBA4D4A3C002367FEF@ALPMBAPA12.e2k.ad.ge.com>
         <1521038471.4508.25.camel@HansenPartnership.com>
         <1521047286.3547.470.camel@linux.vnet.ibm.com>
         <1521048306.4508.56.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18031516-0020-0000-0000-0000040556FB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031516-0021-0000-0000-000042996080
Message-Id: <1521130749.3547.608.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803150178
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-14 at 10:25 -0700, James Bottomley wrote:
> On Wed, 2018-03-14 at 13:08 -0400, Mimi Zohar wrote:
[..]
> > Adding additional support for post IMA-initialization for TPM's built
> > as kernel modules is clearly not optimal for all of the reasons
> > provided to now and will be confusing, but could be supported.  This
> > delayed loading of the TPM needs to be clearly indicated in both the
> > audit log and in IMA's measurement list.
> 
> Why if the measurement chain isn't broken?  The way I'm thinking of
> implementing it, IMA wouldn't even know.

I'm not sure this is good news.

> What would happen is that a
> NULL tpm chip in tpm_pcr_read/tpm_pcr_extend would trigger the usual
> search for the first TPM but if none were found and we'd booted on an
> EFI system, we'd just use the EFI driver to do perform the operation.

If EFI is extending the TPM, will the events be added to the TPM event
log or to the IMA measurement list?   Up to now the IMA boot aggregate
record includes PCRs from 0 - 7.  With these PCRs, the boot aggregate
wouldn't change when booting the same kernel.  Would you change the
boot-aggregate to include these other PCRs?

> There's probably a bit of additional subtlety making the kernel and EFI
> agree which TPM they're using in a multi-TPM situation.

Agreed

> The EFI driver isn't full featured: it only does measurement and
> logging, but it looks like that's all IMA needs.

What happens for non EFI systems, when you can't extend the TPM?

Mimi
