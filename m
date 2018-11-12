Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59495C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B9D223C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="c312KTr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B9D223C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbeKLSq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:46:28 -0500
Received: from mail-eopbgr780088.outbound.protection.outlook.com ([40.107.78.88]:60832
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727996AbeKLSq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7n9T0Vk5Ag9KaXEKRRZpqlr+ku6qv5OOneYUopdSrQ=;
 b=c312KTr63Shnuwdh0xL9GRCFmWq3a98LqQSFdmUCuzFTtMzcxDpJT6uCLZlJoR9M3QJKFCRGBrcFknUywtDh2acO8D6ektznfh/1UOSiReXpSTQdhcH/JHCXMOi5jA49B4FKvmv9sTxzHHhfdM8b1NL6u+T0RhpGt5roTSQ4FL8=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB5469.namprd07.prod.outlook.com (20.177.249.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.31; Mon, 12 Nov 2018 08:54:10 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149%5]) with mapi id 15.20.1294.044; Mon, 12 Nov 2018
 08:54:10 +0000
From:   "Richter, Robert" <Robert.Richter@cavium.com>
To:     Julien Thierry <julien.thierry@arm.com>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Subject: Re: [PATCH 01/10] irqdomain: Add interface to request an irq domain
Thread-Topic: [PATCH 01/10] irqdomain: Add interface to request an irq domain
Thread-Index: AQHUduWsV81u7L9sPUy5ady0TaCFAqVFq2AAgABPXYCAAS4agIAEs+EA
Date:   Mon, 12 Nov 2018 08:54:10 +0000
Message-ID: <20181112085402.GG4064@rric.localdomain>
References: <20181107220254.6116-1-rrichter@cavium.com>
 <20181107220254.6116-2-rrichter@cavium.com>
 <e640a85d-6e2c-835b-d104-ef42eada8fde@arm.com>
 <20181108150355.GA4064@rric.localdomain>
 <efea8ead-6432-7cc4-fe54-034e34ce2f2d@arm.com>
In-Reply-To: <efea8ead-6432-7cc4-fe54-034e34ce2f2d@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0502CA0056.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::33) To SN6PR07MB5326.namprd07.prod.outlook.com
 (2603:10b6:805:73::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.179.10.186]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB5469;6:5QIa5bNQ+Aptl308FCFGRNtOn7eGe4cy3a3ILIUK9JomDYX0ZzyxrdDdUwAKacD/JPiZBHU1GlH/4e4PkgGmuxb3NHj1CI7ONAaY6Bw3VUYvnAZ6+7DZHEagu1+7oE/8ruE2fwxoH2oHR17R6aglLeHIrPx2ldEnMtVIDtcO8amAYkCYwDwy+75RGM0XaGAwniSy333i+DmM3mwfk7MdqJKGMW9B0miCGfU7vs1Tev4jDK9eFqa+LdyPBPbF3SwpxZfIfTb1UwkVv+lZQksiYm/3b2x+16ZO373BA6U6kbszZQLdzAQWINbMdCRHcTxyC76SF5VhZcqcg8Cfjwh01WnMZ7a51ypRLFU3yeJIbS39QIT0m0m8niBt7c7y3JhU/EL/xnQUOaFqLfyuw9q0hU5+QnhOemYzXcutKtLIwBfy2SnJ3/tcBP4Q5h2O62VkrX+YXIzROoB6GMiF01dDCg==;5:U0YWJKWjvTXqY3wop5nqfxuBxAyKPu26zjELC6+OPpACtHGEt8qTZsXPC2HqS53pUpHznaz3BlYdVFES+fkYgWd5bVElA3fUth8q/DgpyiyMl3uTxO0Ov9U3buCcbwvO4j3hZMc14iIypxozGraqKkVpN/U5Z+8f+KjozlJCBDI=;7:M+umSpK8BWYwmr4hFocSnOSHj8EuS0tt7nE8cxn6+1GIUrTxO/Ap0RkkCK0Wm1ng5KwjpamKxo84LAbokbpN5cVkKjfM4ucvmkxp1Ok4HrIld0n4k4v2t9SDExbHDXO1QNLxYy71GMI849vD23og+Q==
x-ms-office365-filtering-correlation-id: f1e77153-63f0-43e4-f121-08d6487c6944
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB5469;
x-ms-traffictypediagnostic: SN6PR07MB5469:
x-microsoft-antispam-prvs: <SN6PR07MB5469DF9FCD5128EB518A5383F1C10@SN6PR07MB5469.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(131327999870524)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231382)(944501410)(52105112)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB5469;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB5469;
x-forefront-prvs: 0854128AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(2906002)(3846002)(6116002)(39060400002)(229853002)(6916009)(33656002)(2900100001)(256004)(54906003)(72206003)(33896004)(93886005)(66066001)(14444005)(4326008)(386003)(6506007)(1076002)(26005)(102836004)(52116002)(76176011)(14454004)(99286004)(53546011)(5660300001)(68736007)(6436002)(486006)(305945005)(71190400001)(71200400001)(446003)(11346002)(476003)(86362001)(7736002)(6246003)(53936002)(478600001)(316002)(105586002)(81156014)(6486002)(25786009)(97736004)(7416002)(106356001)(81166006)(9686003)(6512007)(8676002)(186003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB5469;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3ji1oUnZMVj3WsW+GbT6fcRysqsYWPx/G+vM6XotMEC0fRJYjz/bp+wdykly6qUpq/T2bPUqTiK55Gyq+eNC843je5HCcrORvbtPH/lgMco+wKtIgCbx2YRTFGc1SNhinAmbZ38Rcho6p+m7Qkjj4I7E6jmwkCvinqOe/FjZ00S6iQD1MJJNoJwVorqs5uR2RCEh3LVkRP7Myup5g0LyHqEIV4eE6w136sKiBw56mW6O7MU6DUOJhrYuvYct1gMxrRm+WJ5oeirwI5E0YJZGDAdVVCukpURE451bVXi2+oOgByfZ4vrgaU/3K/sXFXoFL4QLsFQd/t9lYkxYJ2rrTKOXa2Wupp9MxE+2zynH3VU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CAB171BB7293BD49BC1FB0D27EBE4066@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e77153-63f0-43e4-f121-08d6487c6944
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2018 08:54:10.4568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Julien,

On 09.11.18 09:05:11, Julien Thierry wrote:
> On 08/11/18 15:05, Richter, Robert wrote:

> >>>+static void irq_domain_handle_requests(struct fwnode_handle *fwnode,
> >>>+                        enum irq_domain_bus_token bus_token)
> >>>+{
> >>>+     struct irq_domain *domain;
> >>>+     struct irq_domain_request *request;
> >>>+
> >>>+     if (!fwnode)
> >>>+             return;
> >>>+redo:
> >>>+     domain =3D irq_find_matching_fwnode(fwnode, bus_token);
> >>>+     if (!domain)
> >>>+             return;
> >>>+
> >>>+     mutex_lock(&irq_domain_mutex);
> >>>+
> >>
> >>Why do we need to take the mutex before checking the domain fields?
> >>Can't we delay it?
> >
> >The list is protected by the mutex. irq_find_matching_fwnode() also
> >accesses the list and must use the same mutex.
> >
> >>
> >>>+     if ((domain->fwnode !=3D fwnode) && (domain->bus_token !=3D bus_=
token)) {
> >>
> >>Why do we even need that check?
> >
> >The domain token might have changed after irq_find_matching_fwnode()
> >and before mutex_lock(), we do a recheck here. Some sort of try-lock.
> >
> >Note: I found the check being wrong here, it needs to be corrected to:
> >
> >      if ((domain->fwnode !=3D fwnode) || (domain->bus_token !=3D bus_to=
ken)) {
> >
> >>
> >>Isn't the point of passing fwnode and bus_token to
> >>irq_find_matching_fwnode to find a domain with those properties?
> >
> >Yes, but properties may change and also the list itself.
>=20
> Hmmm, that check is unrelated to the list, you're just checking the
> domain you just retrieved.
>=20
> Can you clarify which properties may change? If the irq_domain fields
> can change (I guess if e.g. another cpu modifies the domain with
> irq_domain_update_bus_token), they could still be changed between the
> moment you retrieved the domain and the moment you call the handler. Why
> is that not an issue if we worried about properties changing before
> removing the request from the list?
>=20
> Maybe some comment would help here.

The check makes sure we can use the irq_domain_requests list for the
serialization of irq domain updates. Suppose the following:

Thread1         Thread2

~~~~~~~~~~~~~~~~~~~~~~~~~       mutex
fwnode
token1
handler1                        request_fwnode()
~~~~~~~~~~~~~~~~~~~~~~~~~
domain1
fwnode
token1                          find_fwnode()
~~~~~~~~~~~~~~~~~~~~~~~~~
                domain1
                fwnode
                token1          find_fwnode()
~~~~~~~~~~~~~~~~~~~~~~~~~
                domain1
                fwnode
                token1
                handler1        call_handler()
~~~~~~~~~~~~~~~~~~~~~~~~~
                domain1
                fwnode
                token2          update_token()
~~~~~~~~~~~~~~~~~~~~~~~~~
                domain2
                fwnode
                token1          update_token()
~~~~~~~~~~~~~~~~~~~~~~~~~
                fwnode
                token1
                handler1        request_fwnode(), reschedule request
~~~~~~~~~~~~~~~~~~~~~~~~~
domain1                         <---- called with wrong domain, should be d=
omain2
fwnode
token1
handler1                        call_handler()
~~~~~~~~~~~~~~~~~~~~~~~~~

The check handles a corner case and as such the conditions for
triggering it are rare and might look a bit constructed, but it *can*
happen. So see the check more like an assertion in the code that does
not hurt much. How about the following comment:?

	/*
	 * For serialization of irq domain updates make sure to handle
	 * (and remove) the request only if the domain still matches
	 * the request.
	 */

>=20
> >
> >>
> >>>+             mutex_unlock(&irq_domain_mutex);
> >>>+             goto redo;
> >>>+     }
> >>>+
> >>>+     list_for_each_entry(request, &irq_domain_requests, list) {
> >>
> >>Shouldn't you use list_for_each_safe if you want to remove elements of
> >>the list inside the loop?
> >
> >No, we do a complete redo again without further iterating the list. We
> >need to do this since the handler must be called with the mutex
> >unlocked (to be able to manipulate the irq domain list in the callback
> >and to be in non-atomic context). After we unlocked the mutex, we must
> >restart again as the list may have changed.
> >
> >>
> >>>+             if (request->fwnode !=3D fwnode ||
> >>>+                 request->bus_token !=3D bus_token)
> >>>+                     continue;
> >>>+
> >>>+             list_del(&request->list);
> >>>+             mutex_unlock(&irq_domain_mutex);
> >>>+
> >>>+             irq_domain_call_handler(domain, request->callback,
> >>>+                                     request->name, request->priv);
> >>>+             irq_domain_free_request(request);
> >>>+
> >>>+             goto redo;
> >>>+     }
> >>>+
> >>>+     mutex_unlock(&irq_domain_mutex);
> >>>+}
> >>>+
> >>>+static int __init irq_domain_drain_requests(void)
> >>>+{
> >>>+     struct irq_domain_request *request;
> >>>+     struct irq_domain *domain;
> >>>+     int ret =3D 0;
> >>>+redo:
> >>>+     mutex_lock(&irq_domain_mutex);
> >>>+
> >>>+     list_for_each_entry(request, &irq_domain_requests, list) {
> >>
> >>Same remark.
> >
> >Same here, the difference is that we can directly operate with the
> >request, no need to check the domain.
> >
> >>
> >>>+             list_del(&request->list);
> >>>+             mutex_unlock(&irq_domain_mutex);
> >>>+
> >>>+             domain =3D irq_find_matching_fwnode(request->fwnode,
> >>>+                                             request->bus_token);
> >>>+             if (domain) {
> >>>+                     irq_domain_call_handler(domain, request->callbac=
k,
> >>>+                                             request->name, request->=
priv);
> >>>+             } else {
> >>>+                     ret =3D -ENODEV;
> >>>+                     pr_err("%s-%d: Unhandled domain request\n",
> >>>+                             request->name, request->bus_token);
> >>>+             }
> >>>+
> >>>+             irq_domain_free_request(request);
> >>>+
> >>>+             goto redo;
> >>
> >>Hmmm, are you starting a loop to break out of it at each iteration?
> >
> >We have to as the list lock was released which is needed for
> >irq_find_matching_fwnode() and the callback handler.
> >
> >>
> >>Wouldn't it be much simpler to have something like the following?
> >>
> >>        while (!list_empty(&irq_domain_requests) {
> >>                mutex_lock(&irq_domain_mutex);
> >>                request =3D list_first_entry_or_null(&irq_domain_reques=
ts,
> >>                                        struct irq_domain_request,
> >>                                        list);
> >>                if (request)
> >>                        list_del(&request->list);
> >>                mutex_unlock(&irq_domain_mutex);
> >
> >At this point my implmentation has only 5 lines of code and uses one
> >list command less than your's. I am also not happy using list_empty()
> >without the lock hold (though it seems to be used that way elsewhere).
>=20
> I'm not sure why the number of list commands is relevant.

You said "simpler".

> "list_for_each_entry" just already combines a bunch of operations, but
> caries a completely different meaning (and probably expands code in the
> function that is never used).
>=20
> For irq_domain_drain, you take the first element as long as there is one
> and do stuff with it, so having something like:
>=20
>        mutex_lock();
>        while (!list_empty()) {
>                request =3D list_first_entry();
>                list_del(request->list);
>=20
>                // unlock and relock as you please
>                // and do stuff
>        }
>        mutex_unlock();
>=20
> Or if you are really concerned about the number of list commands:
>=20
>        mutex_lock();
>        while ((request =3D list_first_entry_or_null()) !=3D NULL) {
>                list_del(request->list);
>=20
>                // unlock and relock as you please
>                // and do stuff
>        }
>        mutex_unlock();
>=20
> To me this makes it much easier to get what you are trying to do and I
> don't think it is less efficient that your version (but I could be wrong)=
.

Both is not much far away from what I have now. To me it is just a
flavor. I don't like the assignment in a condition. And if you fill in
the args it doesn't fit into a single line and doesn't look that easy
anymore.

>=20
>=20
> For irq_domain_handle_request, I think I agree that it is actually
> different from irq_domain_drain, but it is hard to see in my opinion
> because of how the functions are structured. So I would suggest
> something like:
>=20
>        while ((domain =3D irq_domain_find(...)) !=3D NULL) {
>                struct irq_domain_request *found =3D NULL;
>=20
>                mutex_lock();
>=20
>                // Do the check on domain if it is needed
>=20
>                list_for_each_entry(request, ..., list) {
>                        if (request->fwnode !=3D fwnode ||
>                            request->bus_token !=3D bus_token)
>                                continue;
>=20
>                        list_del(request->list);
>                        found =3D request;
>                        break;
>                }
>                mutex_unlock();
>=20
>                if (found) {
>                        // call handler, etc...
>                }
>        }
>=20
>=20
> Personally, I find those flow much easier to follow than when using
> gotos to break out of loops.

This does not work and ends up in an endless loop, only the request is
removed from the request list, not the node from the node list.

>=20
> This is just my suggestion so feel free to disregard if the maintainers
> agree with your current approach.

Yeah, I probably can live with an alternative implementation, but
let's wait for others to comment.

Thanks again,

-Robert
