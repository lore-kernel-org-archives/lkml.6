Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569BFC4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6F42075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xeVq2Yrk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6F42075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeIGDaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 23:30:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40476 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbeIGDaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 23:30:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w86MmiSh177486;
        Thu, 6 Sep 2018 22:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type; s=corp-2018-07-02;
 bh=rYRfFkfCCzz5O8duSy+Nq4s5uTzRO1fJqU34I3s6NY0=;
 b=xeVq2YrkOe+82rof9VnxbxwCHjWde7W8WfR+Z9sPZHKfeFoicFqdHltibozj6o00gbXX
 qrxu6yQCWaL39jZXs968CA7EclkKf6EQ+A2eoxa8VHdB/slbNJUVIjbU8gK27vE7lyeH
 WmHtUuXF1Y6teUicAeIDOkYCA8aRQBAuBu8XNTG9synuygKZNpA0xB5Sq2fgQ0j3XClT
 mYtYS9nyFAZHs3c/YZuF7PzZZ+ZAxPdDIi0PbUOkluBgfzVrle21K3lTWOGn0JUsWNQJ
 TcZVQyD2VmNpUA4/bcCPC0xFYRHXBzSXdc/7aMUo5pM/iYQYOktGcAT7ZeeHBMM34xW4 SQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2m7jqpxun5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Sep 2018 22:52:22 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w86MqLfT028850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Sep 2018 22:52:22 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w86MqLCR002254;
        Thu, 6 Sep 2018 22:52:21 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Sep 2018 15:52:21 -0700
Subject: Re: [PATCH v2] xen: avoid crash in disable_hotplug_cpu
To:     Olaf Hering <olaf@aepfle.de>
Cc:     xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20180906063712.28639-1-olaf@aepfle.de>
 <b7306d7f-e827-6556-e1bb-4b934a162e46@oracle.com>
 <20180906223145.37f7009b.olaf@aepfle.de>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <904b8bf8-ce80-2751-04bf-de1e450ef58c@oracle.com>
Date:   Thu, 6 Sep 2018 18:53:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906223145.37f7009b.olaf@aepfle.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="auAW3TJhCbkwOPZEQCY9BtNozEvZC8EIu"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9008 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809060222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--auAW3TJhCbkwOPZEQCY9BtNozEvZC8EIu
Content-Type: multipart/mixed; boundary="Qsz2hA954rg39Vg9lPeOJz7WCrKPmXf3t";
 protected-headers="v1"
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
 open list <linux-kernel@vger.kernel.org>
Message-ID: <904b8bf8-ce80-2751-04bf-de1e450ef58c@oracle.com>
Subject: Re: [PATCH v2] xen: avoid crash in disable_hotplug_cpu
References: <20180906063712.28639-1-olaf@aepfle.de>
 <b7306d7f-e827-6556-e1bb-4b934a162e46@oracle.com>
 <20180906223145.37f7009b.olaf@aepfle.de>
In-Reply-To: <20180906223145.37f7009b.olaf@aepfle.de>

--Qsz2hA954rg39Vg9lPeOJz7WCrKPmXf3t
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

On 09/06/2018 04:31 PM, Olaf Hering wrote:
> Am Thu, 6 Sep 2018 14:45:57 -0400
> schrieb Boris Ostrovsky <boris.ostrovsky@oracle.com>:
>
>> On 09/06/2018 02:37 AM, Olaf Hering wrote:
>>> The command 'xl vcpu-set 0 0', issued in dom0, will crash dom0:
>>> This happens because handle_vcpu_hotplug_event is called twice. In th=
e
>>> first iteration cpu_present is still true, in the second iteration
>>> cpu_present is false which causes get_cpu_device to return NULL.
>>> In case of cpu#0, cpu_online is apparently always true.
>> I think we should check both this and num_online_cpus() !=3D 0.
> This can not possibly help. cpu#0 is the first one that goes offline.
> IF cpu0_hotpluggable is broken, then only "if (!cpu) return;" can help.=



And maybe that needs to be part of the check, in addition to
cpu_is_hotpluggable() test.

Offlining CPU0 is problematic. For example, look at xen_pv_cpu_disable().=




-boris


--Qsz2hA954rg39Vg9lPeOJz7WCrKPmXf3t--

--auAW3TJhCbkwOPZEQCY9BtNozEvZC8EIu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExAVKDNg/TOdD61Yyit52kIbKwbIFAluRr/UACgkQit52kIbK
wbLYeRAAhsnCpb/DSHlF5gDBmxU3YHyAY7yCGZJYAtqNoQFytITDv2MupWiiVHqW
+RuAIlLD85ytK62bp/2+Fh30NnM9o6ePBTWUthotP+PS2QQ8yHiv5k0gEMzvlm7/
TMOposgvv91EKXLFHJd0xQVjHlNETN2gkajUdIfw5jx5AbKXOC46xxNcw8hlWSqP
CuZBzvC+FRCOAC4JEdOu5t9vunMbvGoj5WQuSXFgh50a7Y+ujXrRKtUvEHG2tkOw
JWJq7M+Dy/yj12/9JZdVVaNGviqGyedIUCUmYYSp/Nq7ciO+ji0kAw6ZFh12xr1T
6R6YADjWNw8LmaCn8TaI0a5gGsWx5d/Sq9oi+TM3NNgj2F1WIP+bNnTNjnOkepfr
HbLRgJgtDPor3bewPhTV30Oj5nE1YMEfphRwCIXiUTp6f8dRTUlGVAWo+f36OiN6
XWwY79v0iK2JZewp7ljlpRoTO6tZs6d5YKq7dBanoomyC/DhHNrAirrGdXmrQAaW
IDSyJayhcdHdKbr/eBlozTJfHswAkA//fTxUmMVReUOr1E+Zz5+xcRYeQ3G1EUKv
xQK5+GVnXCls885J6vlwaiFVRjc8B5SfftW7pm9IdXX8AUiVjkBFVht/oyCbjm19
ucXgbiueGZTV+hsh8UcZsLPphbYnYDD4H0s/hF6ZHLgyLf1/vNc=
=obmP
-----END PGP SIGNATURE-----

--auAW3TJhCbkwOPZEQCY9BtNozEvZC8EIu--
