Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A67C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8650F21104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="sRGQ6I9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8650F21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbeKUNzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 08:55:07 -0500
Received: from mail-eopbgr680084.outbound.protection.outlook.com ([40.107.68.84]:27704
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725960AbeKUNzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 08:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfhDXSiefDH66au2N2ZUCUrog4Xp88Z23Imn9+5AnAs=;
 b=sRGQ6I9QimADpml23YH0cnNxedD5mO40MsqaKkyVlyD+ybjiRZbRYuoH7A3CNx0h5+XLWrSvOad+4H92TlRmu8l3N6XDTBI0plDyWsTlp+Jj3T0dY++w6I+r4X9itGdV4Y5LVKCHSqjdZKhJCxoUMujSRBJ9P9FtQkckxPnxw1E=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4952.namprd05.prod.outlook.com (20.177.229.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.12; Wed, 21 Nov 2018 03:22:27 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1361.015; Wed, 21 Nov 2018
 03:22:27 +0000
From:   Nadav Amit <namit@vmware.com>
To:     David Hildenbrand <david@redhat.com>
CC:     linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        kexec-ml <kexec@lists.infradead.org>,
        pv-drivers <pv-drivers@vmware.com>,
        Xavier Deguillard <xdeguillard@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julien Freche <jfreche@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 6/8] vmw_balloon: mark inflated pages PG_offline
Thread-Topic: [PATCH v1 6/8] vmw_balloon: mark inflated pages PG_offline
Thread-Index: AQHUf/EKzdnZjJR4dUWw5mvkN0A5p6VZkvcA
Date:   Wed, 21 Nov 2018 03:22:26 +0000
Message-ID: <9F78496F-EBAE-4248-80F0-0CB55CEFA238@vmware.com>
References: <20181119101616.8901-1-david@redhat.com>
 <20181119101616.8901-7-david@redhat.com>
In-Reply-To: <20181119101616.8901-7-david@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4952;20:dl9oq/Z/JWBeD1M2HtBNJ+dwSSnMzwqRP+YYfWXm38ia0yShRbdngMISk0O4ERdKDweqzxtR+yOrdMAViYU+MjTDg015LKDesv66sDHw/ShYB1d2qxxI3QQCGCRoPH+/gfPLJTcki6gEHVs8olkvugPUoHma3i9s6xYHt9D+KDs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 44d83171-b30e-443d-97b7-08d64f60900c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4952;
x-ms-traffictypediagnostic: BYAPR05MB4952:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <BYAPR05MB495280F4EB4B8429001089ECD0DA0@BYAPR05MB4952.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231442)(944501410)(52105112)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4952;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4952;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(39860400002)(396003)(346002)(199004)(189003)(316002)(81156014)(229853002)(81166006)(8936002)(6916009)(83716004)(6116002)(3846002)(86362001)(2900100001)(6486002)(71200400001)(26005)(6436002)(66066001)(82746002)(25786009)(53546011)(14444005)(256004)(305945005)(14454004)(7416002)(7736002)(99286004)(6506007)(36756003)(186003)(76176011)(102836004)(97736004)(71190400001)(54906003)(105586002)(106356001)(6246003)(4326008)(5660300001)(476003)(446003)(11346002)(53936002)(6512007)(2616005)(68736007)(486006)(478600001)(2906002)(33656002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4952;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xNJF7QkowP6KTW/tKzf4rpJj7TVXQ3/s24BVU0GBYdIEqZLbBLmnGw8Ih1pAuvIqZiQRQ2tqzgMtwvKb+lu9u9SJZBzu5Cup7jqkiq4LFp1FDmZiwdWmuyXA172101gEyp0OYlndmOmJHL5zWc2Ds9M/3ZZWGNWvvVsPBU2wAcp5mlBs8hsr1nKydSqnxDJVaeXurmlTmgg8ZIHlm+CHsuc1qiYdjcA/v+SMT6SkBoRmydxYTDjFNM2+ZsKYjFmf1FpzUpnbUxzPf630qayRGufoySDdvXhBqMlTTHYGBM/ET3Mh8KLuAsQOzm4DiObn83f4qiVgeQvfenXzevueoXYCr5G6Pj/KoNAX1cz/EoU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12E088AA76269B4A994B7F7315294D9A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d83171-b30e-443d-97b7-08d64f60900c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 03:22:26.9991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4952
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for this patch!

> On Nov 19, 2018, at 2:16 AM, David Hildenbrand <david@redhat.com> wrote:
>=20
> Mark inflated and never onlined pages PG_offline, to tell the world that
> the content is stale and should not be dumped.
>=20
> Cc: Xavier Deguillard <xdeguillard@vmware.com>
> Cc: Nadav Amit <namit@vmware.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Julien Freche <jfreche@vmware.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> drivers/misc/vmw_balloon.c | 32 ++++++++++++++++++++++++++++++++
> 1 file changed, 32 insertions(+)
>=20
> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> index e6126a4b95d3..8cc8bd9a4e32 100644
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@ -544,6 +544,36 @@ unsigned int vmballoon_page_order(enum vmballoon_pag=
e_size_type page_size)
> 	return page_size =3D=3D VMW_BALLOON_2M_PAGE ? VMW_BALLOON_2M_ORDER : 0;
> }
>=20
> +/**
> + * vmballoon_mark_page_offline() - mark a page as offline
> + * @page: pointer for the page

If possible, please add a period at the end of the sentence (yes, I know I
got it wrong in some places too).

> + * @page_size: the size of the page.
> + */
> +static void
> +vmballoon_mark_page_offline(struct page *page,
> +			    enum vmballoon_page_size_type page_size)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < 1ULL << vmballoon_page_order(page_size); i++)

Can you please do instead:

	unsigned int;

	for (i =3D 0; i < vmballoon_page_in_frames(page_size); i++)


> +		__SetPageOffline(page + i);
> +}
> +
> +/**
> + * vmballoon_mark_page_online() - mark a page as online
> + * @page: pointer for the page
> + * @page_size: the size of the page.
> + */
> +static void
> +vmballoon_mark_page_online(struct page *page,
> +			   enum vmballoon_page_size_type page_size)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < 1ULL << vmballoon_page_order(page_size); i++)
> +		__ClearPageOffline(page + i);

Same here (use vmballoon_page_in_frames).

> +}
> +
> /**
>  * vmballoon_page_in_frames() - returns the number of frames in a page.
>  * @page_size: the size of the page.
> @@ -612,6 +642,7 @@ static int vmballoon_alloc_page_list(struct vmballoon=
 *b,
> 					 ctl->page_size);
>=20
> 		if (page) {
> +			vmballoon_mark_page_offline(page, ctl->page_size);
> 			/* Success. Add the page to the list and continue. */
> 			list_add(&page->lru, &ctl->pages);
> 			continue;
> @@ -850,6 +881,7 @@ static void vmballoon_release_page_list(struct list_h=
ead *page_list,
>=20
> 	list_for_each_entry_safe(page, tmp, page_list, lru) {
> 		list_del(&page->lru);
> +		vmballoon_mark_page_online(page, page_size);
> 		__free_pages(page, vmballoon_page_order(page_size));
> 	}

We would like to test it in the next few days, but in the meanwhile, after
you address these minor issues:

Acked-by: Nadav Amit <namit@vmware.com>

Thanks again,
Nadav=20

