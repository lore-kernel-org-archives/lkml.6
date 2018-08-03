Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFC0C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFCC2152B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFCC2152B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbeHCQmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:42:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732205AbeHCQmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:42:36 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w73EhcJH121598
        for <linux-kernel@vger.kernel.org>; Fri, 3 Aug 2018 10:45:56 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kmrwmgg0a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 10:45:56 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 3 Aug 2018 15:45:53 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 Aug 2018 15:45:49 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w73EjmQS36962386
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Aug 2018 14:45:48 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15C86A4040;
        Fri,  3 Aug 2018 17:45:58 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EF8FA405D;
        Fri,  3 Aug 2018 17:45:56 +0100 (BST)
Received: from localhost.localdomain (unknown [9.80.98.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Aug 2018 17:45:56 +0100 (BST)
Subject: Re: [PATCH v2 1/2] security/keys/secure_key: Adds the secure key
 support based on CAAM.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        David Howells <dhowells@redhat.com>,
        Udit Agarwal <udit.agarwal@nxp.com>
Cc:     zohar@linux.vnet.ibm.com, jmorris@namei.org, serge@hallyn.com,
        denkenz@gmail.com, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, sahil.malhotra@nxp.com,
        ruchika.gupta@nxp.com, horia.geanta@nxp.com, aymen.sghaier@nxp.com
Date:   Fri, 03 Aug 2018 10:45:35 -0400
In-Reply-To: <1533306238.4140.1.camel@HansenPartnership.com>
References: <20180723111432.26830-1-udit.agarwal@nxp.com>
         <8060.1533226481@warthog.procyon.org.uk>
         <1533297482.4337.373.camel@linux.ibm.com>
         <1533306238.4140.1.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18080314-0020-0000-0000-000002B0B151
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080314-0021-0000-0000-000020FCE5CC
Message-Id: <1533307535.4337.415.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-03_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808030163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-03 at 07:23 -0700, James Bottomley wrote:
> On Fri, 2018-08-03 at 07:58 -0400, Mimi Zohar wrote:
> > On Thu, 2018-08-02 at 17:14 +0100, David Howells wrote:
> > > Udit Agarwal <udit.agarwal@nxp.com> wrote:
> > > 
> > > > +==========
> > > > +Secure Key
> > > > +==========
> > > > +
> > > > +Secure key is the new type added to kernel key ring service.
> > > > +Secure key is a symmetric type key of minimum length 32 bytes
> > > > +and with maximum possible length to be 128 bytes. It is produced
> > > > +in kernel using the CAAM crypto engine. Userspace can only see
> > > > +the blob for the corresponding key. All the blobs are displayed
> > > > +or loaded in hex ascii.
> > > 
> > > To echo Mimi, this sounds suspiciously like it should have a
> > > generic interface, not one that's specifically tied to one piece of
> > > hardware - particularly if it's named with generic "secure".
> > > 
> > > Can you convert this into a "symmetric" type and make the backend
> > > pluggable?
> > 
> > TPM 1.2 didn't support symmetric keys.  For this reason, the TPM
> > "unseals" the random number, used as a symmetric key, and returns the
> > "unsealed" data to the kernel.
> > 
> > Does anyone know if CAAM or TPM 2.0 have support for symmetric keys?
> 
> It depends what you mean by "support".  The answer is technically yes,
> it's the TPM2_EncryptDecrypt primitive.  However, the practical answer
> is that symmetric keys are mostly used for bulk operations and the TPM
> and its bus are way too slow to support that, so the only real,
> practical use case is to have the TPM govern the release conditions for
> symmetric keys which are later used by a fast bulk encryptor/decryptor
> based in software.
> 
> >  If they have symmetric key support, there would be no need for the
> > symmetric key ever to leave the device in the clear.  The device
> > would unseal/decrypt data, such as an encrypted key.
> > 
> > The "symmetric" key type would be a generic interface for different
> > devices.
> 
> It's possible, but it would only work for a non-bulk use case; do we
> have one of those?

"trusted" keys are currently being used to decrypt other keys (eg.
encrypted, ecryptfs, ...).

Mimi

