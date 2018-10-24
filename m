Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85DBECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB6B207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BJBThkHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB6B207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeJYBVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:21:52 -0400
Received: from mail-sn1nam01on0137.outbound.protection.outlook.com ([104.47.32.137]:27136
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727369AbeJYBVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5y9tsG6vVEdADsuuIW1pEkjV0hWxrOIFWajMDy/cYsk=;
 b=BJBThkHvhGmBr+sJmWDLsndUsYPvKHrgbcqZKgeR/uputrnHOqwzXbh3nbiRh9MDTDSAUYgqpi1jb15GXS9LoWfuM3tCmlNQQ6ygoChFo7qa6IK4SnShC0Va0tjs8s8etVUe4j++Jf6RSc3VaMQ8zqUEKnLsrQdD+35qILBa7Sw=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.8; Wed, 24 Oct 2018 16:53:00 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::6d0b:b90f:7a73:99fb]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::6d0b:b90f:7a73:99fb%8]) with mapi id 15.20.1294.001; Wed, 24 Oct 2018
 16:53:00 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Yi Sun <yi.y.sun@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jgross@suse.com" <jgross@suse.com>,
        "chao.p.peng@intel.com" <chao.p.peng@intel.com>,
        "chao.gao@intel.com" <chao.gao@intel.com>,
        "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: RE: [PATCH v1 2/2] x86/hyperv: make HvNotifyLongSpinWait hypercall
Thread-Topic: [PATCH v1 2/2] x86/hyperv: make HvNotifyLongSpinWait hypercall
Thread-Index: AQHUZ7E6J7MVriGzlECNPmkOKu+8U6Uul5eQ
Date:   Wed, 24 Oct 2018 16:53:00 +0000
Message-ID: <CY4PR21MB07737AA8E3F7E7353D42F5C8D7F60@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <1539954835-34035-1-git-send-email-yi.y.sun@linux.intel.com>
 <1539954835-34035-3-git-send-email-yi.y.sun@linux.intel.com>
In-Reply-To: <1539954835-34035-3-git-send-email-yi.y.sun@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-10-24T16:52:55.3507908Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [12.130.117.98]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:8heH+PbX596/d0ArLlq0m3Cw1DGLIUXvTYSuW+ABp0DuhY43yqYSSTy3gokk7sfzEtjVto4jz+aUfJTL0lgj8/tEjJLZKjWPDMVeF0a7DUavqCfrGFWKLsieC/Hfb7qUDJNbJkphvTgYl7pQ7R3iI72te+7mkRiK9BQiZU2rrjjezsiBlNTYURYiv/0RO9sLqALaAevX1jRHXpqbla2ILqT7mzsK33ODNKN/CRO5CNyO5mdnGAcKy5hdSPr5qPfy0ZejYgz3Lv1byoNEagaog46c/NOcCS4fWDYH/XrmIyS80l1Va3a+O9uHnUnP9C93uV6wK+boe9U85Ss+P80Jvtv97OVYovhNtsRVsNIrlNeBy1aaabfBBWbblWXDEjkNx3rmL4oNt4SVyhXJFHSFUJ7qY3GxbvGkh6Z5LjYwvz0q6Gld671qPr+MaYKvfgBCRmumnjSVTWMIqbZRuEH59w==;5:iKemLWLB1f9KHfuyqUNbhb565km43fQooGJMrecRjida4XiuwIywz6yXJNETP7U7IjB6jGXYeVIJISdSE//FiBIxHa7hE4Sis7+/eEqrnx9gOaICueO1z0inpCw5/y+KbtBs95nTRb7M6AItdXnMrdrAOy/9hVRupi9vp9kY7J0=;7:IXOdcdV0SvQWmSjoSy8CHiYN4cHTX6lXdJd1XRI/CyeNq8vb2idHNANUNQFs9zACnB8ePKRim3tkOtVz42EMcZYw/UPQ9rJMKMhyHNGcpg/iu+uU6ZqjWr5iz0tpmWJH3H0ArEkpBECgq/iKrL+9Qw==
x-ms-office365-filtering-correlation-id: e3acf948-1d1b-481f-1418-08d639d1285a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
x-microsoft-antispam-prvs: <CY4PR21MB011824B4C38564FAA65BDDA0D7F60@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220027)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(97736004)(102836004)(6346003)(74316002)(66066001)(68736007)(7736002)(2906002)(8990500004)(6436002)(305945005)(186003)(6116002)(5660300001)(107886003)(10090500001)(110136005)(256004)(33656002)(14444005)(54906003)(26005)(2900100001)(2501003)(8936002)(81156014)(3846002)(81166006)(6246003)(486006)(316002)(10290500003)(86612001)(55016002)(4326008)(5250100002)(478600001)(6506007)(476003)(446003)(11346002)(8676002)(86362001)(7696005)(14454004)(76176011)(25786009)(9686003)(106356001)(53936002)(71200400001)(71190400001)(229853002)(105586002)(99286004)(22452003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-microsoft-antispam-message-info: B7I1GtVVysHcB26GKfAUhBq/VQ1DAQkAb4xTY+Tcx6p4pKwF5NSeukx1dA5pa4GkHaR6csjDQPzcdC9zvbhl94vX4d9GkRk7PK7mo1OBt4aeIP48v2jkhKF7cH6KUKN8ZL90ZherMrFNaE1WetF4ZAPYlgXnn1IGz9zJP9ws55YUtpGf1MoDFWgl9pIkgbIwfJZ+VEmv3P7UwN2/5cudsSNxmJfNVPBMnhh2onuH+zW/QntQHMsngo07zgU7f3Ob0qGO8LZh8r0DFZwRkolkxhdRPTMVHgzXR/Myr646ZAMnYqFRqqDxEmcb7cz0ADElTGYoiAXnqRzrAwnJGxdoRO7i6xXsjcNnQXbueyUwXis=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3acf948-1d1b-481f-1418-08d639d1285a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 16:53:00.5432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yi Sun <yi.y.sun@linux.intel.com>  Sent: Friday, October 19, 2018 6:1=
4 AM
>=20
> The HvNotifyLongSpinWait hypercall (HVCALL_NOTIFY_LONG_SPIN_WAIT)
> is used by a guest OS to notify the hypervisor that the calling
> virtual processor is attempting to acquire a resource that is
> potentially held by another virtual processor within the same
> Virtual Machine. This scheduling hint improves the scalability of
> VMs with more than one virtual processor on Hyper-V.
>=20
> Per MSFT TLFS, the retry number (SpinWaitInfo) is sent to hypervisor
> only when the retry number exceeds the recommended number. If
> recommended number is 0xFFFFFFFF, never retry.

The HvNotifyLongSpinWait hypercall should be understood to be
advisory only.  As you noted, it is a scheduling hint to the
hypervisor that some virtual CPU in the VM holds a spin lock.  Even
though Linux knows which vCPU holds the spin lock, the hypercall
does not provide a way to give that information to Hyper-V.  The
hypercall always returns immediately.

The "retry number" is a bit mis-named in the Hyper-V Top Level
Functional Spec (TLFS).  It is essentially a threshold value.  Hyper-V is
saying "don't bother to advise me about the spin lock until you have
done a certain number of spins."  This threshold prevents
over-notifying Hyper-V such that the notification becomes somewhat
meaningless.   It's not immediately clear to me why the hypercall passes
that value as an input, but maybe it lets the Hyper-V scheduler prioritize
among vCPUs based on how many times they have spun for a lock.  I
think we were told that current Hyper-V implementations ignore this
input value anyway.

I believe the description of the sentinel value 0xFFFFFFFF in the
Hyper-V TLFS is incorrect.  Because it is the max possible threshold
value, that value in the EBX register just means to not ever bother to
notify.   The description should be "0xFFFFFFFF indicates never to notify."
The value does *not* indicate anything about retrying to obtain the
spin lock.

>  static bool __initdata hv_pvspin =3D true;
>=20
> +bool hv_notify_long_spin_wait(int retry_num)

retry_num should probably be declared as unsigned int.  You
don't want it to be treated as a negative number if the high
order bit is set.

> +{
> +	/*
> +	 * Per MSFT TLFS, the SpinWaitInfo is sent to hypervisor only when
> +	 * the retry number exceeds the recommended number.
> +	 *
> +	 * If recommended number is 0xFFFFFFFF, never retry.
> +	 */
> +	if (ms_hyperv.num_spin_retry =3D=3D HYPERV_SPINLOCK_RETRY_NEVER)
> +		return false;
> +
> +	if ((0 =3D=3D retry_num % ms_hyperv.num_spin_retry) && retry_num)

I don't know if the "%" function is right here.  Your implementation will
notify Hyper-V on every multiple of num_spin_retry.   The alternative is to
notify once when the threshold is exceeded, and never again for this
particular attempt to obtain a spin lock.  We should check with the Hyper-V
team for which approach they expect to be used.

> +		hv_do_fast_hypercall8(HVCALL_NOTIFY_LONG_SPIN_WAIT,
> +				      retry_num);

The Hyper-V TLFS seems to be inconsistent on whether the input parameter
is 32-bits or 64-bits.   In one place it is typed as UINT64, but in another=
 place
it is shown as only 4 bytes.  Need to clear this up with the Hyper-V team a=
s
well.

> +
> +	return true;

I don't see a need for this function to return true vs. false.  Any calling=
 code
should not change its behavior based on num_spin_retry.   This function wil=
l
either notify Hyper-V or not notify Hyper-V, depending on whether the numbe=
r
of attempts to obtain the spinlock meets the threshold.  But calling code w=
ill
do the same thing regardless of whether such a notification is made.=20

Michael

