Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A3BC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27732064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VwS2CzQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27732064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbeJOTlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:41:17 -0400
Received: from mail-he1eur01on0101.outbound.protection.outlook.com ([104.47.0.101]:2094
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726319AbeJOTlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6irs5EtJpNT/5DPPwbOvEZdeikEzb64u0HjtUvSExM=;
 b=VwS2CzQ+3fV98XFeu5uF2SWgfVtW/xUJAf58lgV2Qorb4j9CPwibGBVJAzXVZDwURcYkOu5di/CUSKKMCvwpukzJgPK5VJ/wA1i9l+QYZATR6eLLdg7CdXShiMkuw7YMe4WaB5lzkHXShxcScnenFJmhVlVItatS9W3Ziv1WDQ0=
Received: from HE1PR0801MB2026.eurprd08.prod.outlook.com (10.168.95.15) by
 HE1PR0801MB1546.eurprd08.prod.outlook.com (10.167.190.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Mon, 15 Oct 2018 11:56:08 +0000
Received: from HE1PR0801MB2026.eurprd08.prod.outlook.com
 ([fe80::81:90cd:bab6:ed7a]) by HE1PR0801MB2026.eurprd08.prod.outlook.com
 ([fe80::81:90cd:bab6:ed7a%2]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 11:56:08 +0000
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
CC:     "hughd@google.com" <hughd@google.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "imbrenda@linux.vnet.ibm.com" <imbrenda@linux.vnet.ibm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "jia.he@hxt-semitech.com" <jia.he@hxt-semitech.com>,
        "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "jiang.biao2@zte.com.cn" <jiang.biao2@zte.com.cn>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2] ksm: Assist buddy allocator to assemble 1-order
 pages
Thread-Topic: [PATCH RFC v2] ksm: Assist buddy allocator to assemble 1-order
 pages
Thread-Index: AQHUZGolh3tx7tBnbUaiFPUBBeLjvqUgHbUAgAAVjwA=
Date:   Mon, 15 Oct 2018 11:56:08 +0000
Message-ID: <a566060a-b14e-b495-85bc-992e9b7bbf80@virtuozzo.com>
References: <153959597844.26723.5798112367236156151.stgit@localhost.localdomain>
 <20181015123854.5a22846d@p-imbrenda.boeblingen.de.ibm.com>
In-Reply-To: <20181015123854.5a22846d@p-imbrenda.boeblingen.de.ibm.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR04CA0004.eurprd04.prod.outlook.com
 (2603:10a6:206:1::17) To HE1PR0801MB2026.eurprd08.prod.outlook.com
 (2603:10a6:3:50::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0801MB1546;20:r1OktrHJvMwV+n5WV5v62kX2DfvwLyeew8FKzYvhSRLkqItzsFZcAEb/eYZxx5o1zFDzAgPUhVL9JEZQIS86oCtfvUGOazAZyOZ7nM/Hh+cCUV5FzwFE/FR5fp3Fvf7SeOjW+ES5Nl1rAcEm4gV1E8dCxs2lD8af9uBhPAh0UOI=
x-ms-office365-filtering-correlation-id: 3c2ffa04-d488-4150-5385-08d632953162
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1546;
x-ms-traffictypediagnostic: HE1PR0801MB1546:
x-microsoft-antispam-prvs: <HE1PR0801MB1546E9A250BDE1982EC5DE24CDFD0@HE1PR0801MB1546.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991067);SRVR:HE1PR0801MB1546;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1546;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39840400004)(136003)(346002)(376002)(366004)(199004)(189003)(316002)(6486002)(26005)(102836004)(6916009)(6436002)(86362001)(6512007)(2900100001)(68736007)(5660300001)(54906003)(53936002)(105586002)(66066001)(6246003)(31696002)(106356001)(8676002)(478600001)(186003)(8936002)(14454004)(7416002)(81166006)(31686004)(81156014)(575784001)(5250100002)(99286004)(2906002)(52116002)(7736002)(217873002)(2616005)(476003)(4326008)(97736004)(76176011)(53546011)(3846002)(6116002)(11346002)(229853002)(486006)(305945005)(36756003)(256004)(386003)(6506007)(446003)(71200400001)(14444005)(71190400001)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1546;H:HE1PR0801MB2026.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Gsd/hw0xEaOjAQAEmaqKm4DQxMIWTRlR5Q2RGfxuk4ModUnsOy8L6X1tYUUrOVOa37Bexr0jzjlzFmxT2Y9lg65BrHF8iFLyptLAQ8GvqhNW2/qRlnonUro6AaXLrjuXNVJMgbCTWZSceyHJHGeISFqFjKzzqS7tceabgzpp/tUpaEG3IZbUhIKFjouNX9y9zN8abxaao/+Yt7XtZcB7XNm/MJ8Xhw15ZhCcEQq6DocT/iDDckrKdQUO2R0OSNd3bbHoYFclymlesVh+xpCvJSa7SjS67faRf1Z2GZMrwjqk4SSrpCR+2U046zkMHV74zcbX65MWhmM4tNPpHWnXEKzZcL+h7LEqrPUeE5P7gPU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <81E0A1E0B2DD3E4084851879FF1A7DC6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2ffa04-d488-4150-5385-08d632953162
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 11:56:08.7724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1546
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.10.2018 13:38, Claudio Imbrenda wrote:
> I don't have objections to this patch, but I wonder how much impact it
> would have. Have you performed any tests? does it really have such a big
> impact on the availability of order-1 page blocks?=20

I have no synthetic tests on compaction, so this patch is RFC. Maybe you
suggest something? In my test machine I added debug patch on top of this,
which adds a counter of such tree_page preferred pages, and the counter
increments as well. Order-1 page is just a brick of a bigger order pages,
so this patch cares about them.

>=20
> On Mon, 15 Oct 2018 12:33:36 +0300
> Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>=20
>> v2: Style improvements
>>
>> try_to_merge_two_pages() merges two pages, one of them
>> is a page of currently scanned mm, the second is a page
>> with identical hash from unstable tree. Currently, we
>> merge the page from unstable tree into the first one,
>> and then free it.
>>
>> The idea of this patch is to prefer freeing that page
>> of them, which has a free neighbour (i.e., neighbour
>> with zero page_count()). This allows buddy allocator
>> to assemble at least 1-order set from the freed page
>> and its neighbour; this is a kind of cheep passive
>> compaction.
>>
>> AFAIK, 1-order pages set consists of pages with PFNs
>> [2n, 2n+1] (odd, even), so the neighbour's pfn is
>> calculated via XOR with 1. We check the result pfn
>> is valid and its page_count(), and prefer merging
>> into @tree_page if neighbour's usage count is zero.
>>
>> There a is small difference with current behavior
>> in case of error path. In case of the second
>> try_to_merge_with_ksm_page() is failed, we return
>> from try_to_merge_two_pages() with @tree_page
>> removed from unstable tree. It does not seem to matter,
>> but if we do not want a change at all, it's not
>> a problem to move remove_rmap_item_from_tree() from
>> try_to_merge_with_ksm_page() to its callers.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  mm/ksm.c |   16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index 5b0894b45ee5..005508c86d0a 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -1321,6 +1321,22 @@ static struct page
>> *try_to_merge_two_pages(struct rmap_item *rmap_item, {
>>  	int err;
>>
>> +	if (IS_ENABLED(CONFIG_COMPACTION)) {
>> +		unsigned long pfn;
>> +
>> +		/*
>> +		 * Find neighbour of @page containing 1-order pair
>> +		 * in buddy-allocator and check whether it is free.
>> +		 * If it is so, try to use @tree_page as ksm page
>> +		 * and to free @page.
>> +		 */
>> +		pfn =3D page_to_pfn(page) ^ 1;
>> +		if (pfn_valid(pfn) && page_count(pfn_to_page(pfn))
>> =3D=3D 0) {
>> +			swap(rmap_item, tree_rmap_item);
>> +			swap(page, tree_page);
>> +		}
>> +	}
>> +
>>  	err =3D try_to_merge_with_ksm_page(rmap_item, page, NULL);
>>  	if (!err) {
>>  		err =3D try_to_merge_with_ksm_page(tree_rmap_item,
>>
>=20
