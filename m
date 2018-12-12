Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F5FC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0622084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0622084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeLLUmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:42:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46854 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726297AbeLLUmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:42:50 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBCKXiIY039753
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 15:42:48 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pb8nn2by9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 15:42:48 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 12 Dec 2018 20:42:46 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Dec 2018 20:42:40 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBCKgdwh9044340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Dec 2018 20:42:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 174EE42041;
        Wed, 12 Dec 2018 20:42:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 249984203F;
        Wed, 12 Dec 2018 20:42:37 +0000 (GMT)
Received: from dhcp-9-31-102-82.watson.ibm.com (unknown [9.31.102.82])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 12 Dec 2018 20:42:37 +0000 (GMT)
Subject: Re: [RFC PATCH v1 1/5] fs: Add support for an O_MAYEXEC flag on
 sys_open()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Philippe =?ISO-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>, Shuah Khan <shuah@kernel.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, sgrubb@redhat.com,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Date:   Wed, 12 Dec 2018 15:42:36 -0500
In-Reply-To: <20181212144306.GA19945@quack2.suse.cz>
References: <20181212081712.32347-1-mic@digikod.net>
         <20181212081712.32347-2-mic@digikod.net>
         <20181212144306.GA19945@quack2.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18121220-0012-0000-0000-000002D831B5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121220-0013-0000-0000-0000210DAE40
Message-Id: <1544647356.4028.105.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812120176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-12 at 15:43 +0100, Jan Kara wrote:


> > diff --git a/fs/open.c b/fs/open.c
> > index 0285ce7dbd51..75479b79a58f 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -974,6 +974,10 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
> >  	if (flags & O_APPEND)
> >  		acc_mode |= MAY_APPEND;
> >  
> > +	/* Check execution permissions on open. */
> > +	if (flags & O_MAYEXEC)
> > +		acc_mode |= MAY_OPENEXEC;
> > +
> >  	op->acc_mode = acc_mode;
> >  
> >  	op->intent = flags & O_PATH ? 0 : LOOKUP_OPEN;
> 
> I don't feel experienced enough in security to tell whether we want this
> functionality or not. But if we do this, shouldn't we also set FMODE_EXEC
> on the resulting struct file? That way also security_file_open() can be
> used to arbitrate such executable opens and in particular
> fanotify permission event FAN_OPEN_EXEC will get properly generated which I
> guess is desirable (support for it is sitting in my tree waiting for the
> merge window) - adding some audit people involved in FAN_OPEN_EXEC to
> CC. Just an idea...

Assuming the interpreters are properly modified (and signed),
MAY_OPENEXEC closes a major IMA measurement/appraisal gap.  The kernel
has no insight into the files that the interpreter is opening.  Having
the interpreter annotate the file open, allows IMA to differentiate
scripts opening data files from code.

IMA policy rules could then be written requiring code to be signed.

Example IMA policy rules:
measure func=FILE_CHECK mask=MAY_OPENEXEC
appraise func=FILE_CHECK mask=MAY_OPENEXEC appraise_type=imasig

Mimi

