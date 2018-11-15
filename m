Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8F8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4195B2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="imx7Z0/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4195B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388392AbeKPAUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 19:20:41 -0500
Received: from mail-eopbgr140120.outbound.protection.outlook.com ([40.107.14.120]:35303
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732953AbeKPAUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 19:20:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6tA4rWukCCQ6gQXWI33qtt7LDrhVyZ2uGj6HpIEz/Q=;
 b=imx7Z0/r8K+CJ6x2hbBIlF6gxgtmz7P8vMkEwPrrojH2asrd5CTlo/HArv0GryW+NV+50aUjPezT1nlRlm3QT+9UZZzJUDzvAA1vRBCHbWl+OPe9+24RljdWglKn0r624RqsmBuqyepvqJxjwNEwG0eR/oXXFrJ+9SyXT9BfH/A=
Received: from HE1PR0801MB2026.eurprd08.prod.outlook.com (10.168.95.15) by
 HE1PR0801MB1724.eurprd08.prod.outlook.com (10.168.149.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.45; Thu, 15 Nov 2018 14:12:34 +0000
Received: from HE1PR0801MB2026.eurprd08.prod.outlook.com
 ([fe80::b931:788a:1ae:1552]) by HE1PR0801MB2026.eurprd08.prod.outlook.com
 ([fe80::b931:788a:1ae:1552%6]) with mapi id 15.20.1294.045; Thu, 15 Nov 2018
 14:12:34 +0000
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "hughd@google.com" <hughd@google.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
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
Subject: Re: [PATCH v3] ksm: Assist buddy allocator to assemble 1-order pages
Thread-Topic: [PATCH v3] ksm: Assist buddy allocator to assemble 1-order pages
Thread-Index: AQHUZ6gL+/OR+Gi5bUSIlXwX8UvaRqVIEYqAgAj5k4A=
Date:   Thu, 15 Nov 2018 14:12:34 +0000
Message-ID: <0ac6ace8-1e0a-7013-7b1f-2dbe0f35f34f@virtuozzo.com>
References: <153995241537.4096.15189862239521235797.stgit@localhost.localdomain>
 <20181109130857.54a1f383629e771b4f3888c4@linux-foundation.org>
In-Reply-To: <20181109130857.54a1f383629e771b4f3888c4@linux-foundation.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR12CA0057.namprd12.prod.outlook.com
 (2603:10b6:300:103::19) To HE1PR0801MB2026.eurprd08.prod.outlook.com
 (2603:10a6:3:50::15)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [72.2.42.62]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0801MB1724;20:FYxMU4pf51CyqHhERujwJcg3Aj+PePSQSbQwIYLYMWVOj50sbtySgGk7eQVjK7++rpOyxWhWrXqk7DYzNRZpjcz0K1a9W9cpXTVubbKAsXzXghvNFYRCAO0YURVGvxbBW/ivdFvt17vAfm2P8bOwT653ZY4b3pk2QZ+us6bDj+0=
x-ms-office365-filtering-correlation-id: d114a7e3-ebbd-43a0-ab4a-08d64b046367
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1724;
x-ms-traffictypediagnostic: HE1PR0801MB1724:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
x-microsoft-antispam-prvs: <HE1PR0801MB1724DB29D8F33C646A1B6CB9CDDC0@HE1PR0801MB1724.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231415)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:HE1PR0801MB1724;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1724;
x-forefront-prvs: 08572BD77F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(39850400004)(396003)(366004)(199004)(189003)(3846002)(68736007)(386003)(6506007)(6116002)(478600001)(53546011)(102836004)(7416002)(11346002)(476003)(2616005)(446003)(2906002)(36756003)(486006)(6512007)(2900100001)(6916009)(6436002)(6246003)(316002)(186003)(25786009)(26005)(4326008)(6486002)(229853002)(53936002)(66066001)(31696002)(86362001)(8676002)(81156014)(81166006)(71190400001)(71200400001)(14444005)(256004)(8936002)(99286004)(305945005)(52116002)(54906003)(97736004)(5660300001)(14454004)(76176011)(7736002)(105586002)(31686004)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1724;H:HE1PR0801MB2026.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qM0kz/XFFh3VoTPw5yMehL6TIcp7W9BUUWzCFdtMAY/K252brHsALBoEs89XRAIRRqU9vC/fSqwQ3JnAt1JfUEKF+O1jveCpK73DJmYWcHYZXJj231isrDnYYkIGIQdgcSVKaRcZb1cTn0313xl/mjHA97Tsffn6vj+mpyIRhbVMxFE3BNabdoeRROxPU6b+XrWG2hT96750dWtoCxFyjobol5da0lYhlXKQgiSxAByEDMFkDRfR4wVXDQtHGjjX4ANA0bJ+H4thEQK3SS3ROL8IrMvhlOtShtaRgvcX0SZW0GjL0HlRPz0gptP/EO7YNZmRyxb5dwj5ClAWNO+Z/MqsVzeIDZiqF/a7xqoYLjs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <F07B702676D4814DBE08A2199BD6708C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d114a7e3-ebbd-43a0-ab4a-08d64b046367
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2018 14:12:34.6382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.11.2018 0:08, Andrew Morton wrote:
> On Fri, 19 Oct 2018 15:33:39 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wr=
ote:
>=20
>> v3: Comment improvements.
>> v2: Style improvements.
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
>=20
> Seems sensible.
>=20
>>
>> ...
>>
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -1321,6 +1321,23 @@ static struct page *try_to_merge_two_pages(struct=
 rmap_item *rmap_item,
>>  {
>>  	int err;
>> =20
>> +	if (IS_ENABLED(CONFIG_COMPACTION)) {
>> +		unsigned long pfn;
>> +
>> +		/*
>> +		 * Find neighbour of @page containing 1-order pair in buddy
>> +		 * allocator and check whether its count is 0. If so, we
>> +		 * consider the neighbour as a free page (this is more
>> +		 * probable than it's freezed via page_ref_freeze()), and
>> +		 * we try to use @tree_page as ksm page and to free @page.
>> +		 */
>> +		pfn =3D page_to_pfn(page) ^ 1;
>> +		if (pfn_valid(pfn) && page_count(pfn_to_page(pfn)) =3D=3D 0) {
>> +			swap(rmap_item, tree_rmap_item);
>> +			swap(page, tree_page);
>> +		}
>> +	}
>> +
>=20
> A few thoughts
>=20
> - if tree_page's neighbor is unused, there was no point in doing this
>   swapping?

You are sure, and this is the thing I analyzed from several ways before
the submitting. There is no point for doing this swapping, but there is
no point for not doing it too. Both of this approach are almost equal
each other, while the "doing swapping" approach just adds less code.
This is the only reason I prefered it.

> - if both *page and *tree_page have unused neighbors we could go
>   further and look for an opportunity to create an order-2 page.=20
>   etcetera.  This may b excessive ;)

We may do that, there are just less probability to meet a page with
3 free neighbors, than with 1 free neighbor. But we can.

> - are we really sure that this optimization causes desirable results?
>   If we always merge from one tree into the other, we maximise the
>   opportunities for page coalescing in the long term.  But if we
>   sometimes merge one way and sometimes merge the other way, we might
>   end up with less higher-order page coalescing?  Or am I confusing
>   myself?

Just the previous version was RFC, so I'm not 100% sure :) I asked for
compaction tests in reply to v2, but it looks like we don't have them.
I tested this by adding a counter of swapped pages on top of this patch.
The counter grows (though, not so fast as I expected this before).

It's difficult to rate the long term coalescing, since there are many
players, which may introduce external influence, or make page disappear
from process (shrinker, parallel compaction, COW on ksm-ed page, thp).
This all is not completely deterministic, there are too many input
parameters. There is a question whether short term compaction or long
term compaction is more important. I have no answer on this...

Kirill
