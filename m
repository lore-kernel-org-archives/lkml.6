Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908DBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A51B2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfANQLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:11:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726748AbfANQLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:11:53 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0EFqgvE037094
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 11:11:21 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q0t9knbx7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 11:11:17 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 14 Jan 2019 16:11:10 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 14 Jan 2019 16:11:05 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0EGB3sY5243184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 16:11:03 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88B5D42049;
        Mon, 14 Jan 2019 16:11:03 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC69242042;
        Mon, 14 Jan 2019 16:11:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.106.167])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jan 2019 16:11:01 +0000 (GMT)
Subject: Re: [RFC PATCH 2/2] kexec, KEYS: Make use of platform keyring for
 signature verify
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dave Young <dyoung@redhat.com>
Cc:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        ebiggers@google.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Date:   Mon, 14 Jan 2019 11:10:51 -0500
In-Reply-To: <20190113013958.GA14019@dhcp-128-65.nay.redhat.com>
References: <20190109164824.19708-1-kasong@redhat.com>
         <20190109164824.19708-3-kasong@redhat.com>
         <20190111134303.GA12760@dhcp-128-65.nay.redhat.com>
         <1547223220.19931.471.camel@linux.ibm.com>
         <20190113013958.GA14019@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19011416-4275-0000-0000-000002FF115C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011416-4276-0000-0000-0000380D2B76
Message-Id: <1547482251.4156.127.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901140106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-01-13 at 09:39 +0800, Dave Young wrote:
> Hi,
> 
> On 01/11/19 at 11:13am, Mimi Zohar wrote:
> > On Fri, 2019-01-11 at 21:43 +0800, Dave Young wrote:
> > [snip]
> > 
> > > Personally I would like to see platform key separated from integrity.
> > > But for the kexec_file part I think it is good at least it works with
> > > this fix.
> > > 
> > > Acked-by: Dave Young <dyoung@redhat.com>
> > 
> > The original "platform" keyring patches that Nayna posted multiple
> > times were in the certs directory, but nobody commented/responded.  So
> > she reworked the patches, moving them to the integrity directory and
> > posted them (cc'ing the kexec mailing list).  It's a bit late to be
> > asking to move it, isn't it?
> 
> Hmm, apologize for being late,  I did not get chance to have a look the
> old series.  Since we have the needs now, it should be still fine
> 
> Maybe Kairui can check Nayna's old series, see if he can do something
> again?

Whether the platform keyring is defined in certs/ or in integrity/ the
keyring id needs to be accessible to the other, without making the
keyring id global.  Moving where the platform keyring is defined is
not the problem.

Commit a210fd32a46b ("kexec: add call to LSM hook in original
kexec_load syscall") introduced a new LSM hook.  Assuming
CONFIG_KEXEC_VERIFY_SIG is enabled, with commit b5ca117365d9 ("ima:
prevent kexec_load syscall based on runtime secureboot flag") we can
now block the kexec_load syscall.  Without being able to block the
kexec_load syscall, verifying the kexec image signature via the
kexec_file_load syscall is kind of pointless.

Unless you're planning on writing an LSM to prevent the kexec_load
syscall, I assume you'll want to enable integrity anyway.

Mimi

