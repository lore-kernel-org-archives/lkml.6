Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A97C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72E820836
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387781AbfAKQOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:14:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387541AbfAKQOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:14:04 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0BGDxtW079423
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 11:14:03 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pxx9w8wue-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 11:14:02 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 11 Jan 2019 16:14:00 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 11 Jan 2019 16:13:54 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0BGDr1H60948652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 16:13:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53869A4054;
        Fri, 11 Jan 2019 16:13:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82F62A405B;
        Fri, 11 Jan 2019 16:13:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.91.13])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Jan 2019 16:13:51 +0000 (GMT)
Subject: Re: [RFC PATCH 2/2] kexec, KEYS: Make use of platform keyring for
 signature verify
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dave Young <dyoung@redhat.com>, Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, jwboyer@fedoraproject.org,
        keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com,
        bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Date:   Fri, 11 Jan 2019 11:13:40 -0500
In-Reply-To: <20190111134303.GA12760@dhcp-128-65.nay.redhat.com>
References: <20190109164824.19708-1-kasong@redhat.com>
         <20190109164824.19708-3-kasong@redhat.com>
         <20190111134303.GA12760@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19011116-0016-0000-0000-000002440502
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011116-0017-0000-0000-0000329E0F74
Message-Id: <1547223220.19931.471.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901110133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-11 at 21:43 +0800, Dave Young wrote:
[snip]

> Personally I would like to see platform key separated from integrity.
> But for the kexec_file part I think it is good at least it works with
> this fix.
> 
> Acked-by: Dave Young <dyoung@redhat.com>

The original "platform" keyring patches that Nayna posted multiple
times were in the certs directory, but nobody commented/responded.  So
she reworked the patches, moving them to the integrity directory and
posted them (cc'ing the kexec mailing list).  It's a bit late to be
asking to move it, isn't it?

Mimi

