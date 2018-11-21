Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C10C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD54020671
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HziUUreT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD54020671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733196AbeKVHdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:33:16 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54278 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbeKVHdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:33:16 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wALKsaC3007795;
        Wed, 21 Nov 2018 20:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=/Q1Nw2JyQ8IGjRaYO1NUMfhgC+m1Nleu1LVTWACYgsk=;
 b=HziUUreTEcjYmID0ODBKvk3CLVeyGQcFYV7ReboYpur3CoO8f2rdZ+DdNDH5alieqdV+
 AeN7Yxz11nktoYdj3L6OZLVhNEIa4CLE542YJzoJ935FQ0QICkDxip4o4/dA/3aT58tM
 9Efm68aI1Ez21afPbsLyk9x9GUtV87WLm1nXS2+wpkYzHcVwM7y3KTUe6hRGprPg6OSd
 GGNhTl+1g4J2ugbC+tmNMxigzA/gyMzeXmKfUGd9wTNZH/phYxBAaPMUhP5GX7jnyW9f
 rEbXfb12fk6dwyLih8YZDnHhstAMpVOAKuyBtW4Ij1j45GCvekeixwR2PQZWNImy0qSR Kw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2ntadu3qaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Nov 2018 20:56:39 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wALKub5Q011301
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Nov 2018 20:56:37 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wALKuaLC002490;
        Wed, 21 Nov 2018 20:56:36 GMT
Received: from oracle.com (/23.233.26.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Nov 2018 12:56:36 -0800
Date:   Wed, 21 Nov 2018 15:56:34 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>, linux-kernel@vger.kernel.org
Subject: Out of tree module build errors since v4.20-rc1
Message-ID: <20181121205633.oxksehwjg5a2q6rt@oracle.com>
Mail-Followup-To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9084 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=891
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811210182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


My out of tree driver build is now reporting issues with the jump table:

=2E/include/linux/jump_label.h: In function =E2=80=98jump_entry_code=E2=80=
=99:
=2E/include/linux/jump_label.h:153:14: error: dereferencing pointer to inco=
mplete type =E2=80=98const struct jump_entry=E2=80=99
  return entry->code;
              ^~
=2E/include/linux/jump_label.h: In function =E2=80=98jump_entry_set_init=E2=
=80=99:
=2E/include/linux/jump_label.h:180:7: error: dereferencing pointer to incom=
plete type =E2=80=98struct jump_entry=E2=80=99
  entry->key |=3D 2;
       ^~
=2E/include/linux/jump_label.h: At top level:
=2E/include/linux/jump_label.h:212:26: error: array type has incomplete ele=
ment type =E2=80=98struct jump_entry=E2=80=99
 extern struct jump_entry __start___jump_table[];
                          ^~~~~~~~~~~~~~~~~~~~
=2E/include/linux/jump_label.h:213:26: error: array type has incomplete ele=
ment type =E2=80=98struct jump_entry=E2=80=99
 extern struct jump_entry __stop___jump_table[];
                          ^~~~~~~~~~~~~~~~~~~


This happens in v4.20-rc3 as well, so I bisected between v4.19 to
v4.20-rc1 which resulted in the following commit:

b34006c4258c9c86597b6b7123d6a9a3513d6cd7 is the first bad commit
commit b34006c4258c9c86597b6b7123d6a9a3513d6cd7
Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue Sep 18 23:51:41 2018 -0700

    x86/jump_table: Use relative references




Initially I assumed this was my own fault, but my module does not have
these issues when using v4.19.  Is there anything I should try/change in
my module makefile, includes, etc to support this relative reference
code?



Thank you,
Liam

