Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC24C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3861121A49
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=oneplus.com header.i=@oneplus.com header.b="ropVOLtH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfBKMx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:53:56 -0500
Received: from mail-eopbgr1280132.outbound.protection.outlook.com ([40.107.128.132]:54816
        "EHLO KOR01-PS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727106AbfBKMx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:53:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oneplus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZuF4W23b2uhObWENz+guU5vojx1VpAvjBe3lioAi5Q=;
 b=ropVOLtH7M0jqXR1thnZClWpZgVm6V16ZafzmNcg79MEtEI7d7fpLgrhUjVsN18P0tF4HlHNIxhjd1go4h7QUIuW2tMA7i6iTIxwLZDA3G4a9mQa71HfcWIEK55+YfKHWPVLLZ8Lb0WJ/Xug5jRGcz/anNZW+57wBTHz+0YM+9E=
Received: from SL2PR04MB3323.apcprd04.prod.outlook.com (20.177.176.10) by
 SL2PR04MB3081.apcprd04.prod.outlook.com (20.177.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Mon, 11 Feb 2019 12:53:52 +0000
Received: from SL2PR04MB3323.apcprd04.prod.outlook.com
 ([fe80::c429:c599:d8eb:22ce]) by SL2PR04MB3323.apcprd04.prod.outlook.com
 ([fe80::c429:c599:d8eb:22ce%3]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 12:53:52 +0000
From:   Chintan Pandya <chintan.pandya@oneplus.com>
To:     Linux Upstream <linux.upstream@oneplus.com>,
        "hughd@google.com" <hughd@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "mawilcox@microsoft.com" <mawilcox@microsoft.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Chintan Pandya <chintan.pandya@oneplus.com>
Subject: [RFC 0/2] Potential race condition with page lock
Thread-Topic: [RFC 0/2] Potential race condition with page lock
Thread-Index: AQHUwgjWmEDO0ZkgjE+Y+klyARb4XQ==
Date:   Mon, 11 Feb 2019 12:53:51 +0000
Message-ID: <20190211125337.16099-1-chintan.pandya@oneplus.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR04CA0193.apcprd04.prod.outlook.com
 (2603:1096:4:14::31) To SL2PR04MB3323.apcprd04.prod.outlook.com
 (2603:1096:100:38::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chintan.pandya@oneplus.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [14.143.173.238]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SL2PR04MB3081;6:o4j1kJbfmEJhOTYS10ky22wByZxQ3QksZgTNsx8y0ng1NImiI8ZiTgB2vexv+r74HMEC/J0oNzEsVyiD+7D6zJZcf+Zl975nJpZZ+97GaMOyk6xurb6QU6J86UD7rX2bpYGrYmIWVyffDwjCi0PgOnyqdvYm6GXDDmV/yeGr3J0jw0qyCZ+4mXrIM2GYh9QLjqlYkQ2ZNZt+iVOq8VGaCKA0a8fjRAX2bZ4VhOVtIX6ChjHSpvgm8ABd7KBsSlgD879cuNFe9a9XAjCDWOJrJV+EnM/KzL26aBKFn+dXD3XW+5FZtOBQdx6ufbpsWc46wgreU1jezI68eAs/F0sG9wLhJoADyC7CdfTvgCELf+ZVTXhzwLjEhE2TD5jPW4CqUsR4wIn6M9iKnTcwTLplFKDvOyz6RdJ8xYGXWqjXYJwoHKgejgkG3x4yskrr+7hrIaAf56D3nQcXxHqIkKkfCA==;5:q7C8BVFRO0MpK1Vs7hpj0smKB7g3yWFYiIOKf8KhGiLQTOSFfKxFuXNdL6OR9/Cr3Vm8kcYz1nHgUFR5S64H4UTTzpSPnhemUoqcYtT+RQOCNDQsh970cAXWwtlAjsQ9sUoKzuwBxHHEPJ9Un4AgNYFidRNrA+uvbtmyNDRb+taXsbD4xzPx2G4XICVjOW0tf76EPooadUa7dIT7MtF5rg==;7:AckduVsxiwYJ6TXnIQCEaFCfANLDzidilKS/xQlxzq6kOKCDU76zDk8O+gBIEH4fU/syXqgJplgFfHjq30MHT/hrEq1SZA2tdCtYS02sQeSx8CT1miwV9jT99TsrhuUfSF15bl8dkRltsNSKX/OI7w==
x-ms-office365-filtering-correlation-id: 7c65014b-7e56-439f-13e6-08d6901ff8ea
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:SL2PR04MB3081;
x-ms-traffictypediagnostic: SL2PR04MB3081:
x-ld-processed: 0423909d-296c-463e-ab5c-e5853a518df8,ExtAddr
x-microsoft-antispam-prvs: <SL2PR04MB3081BF8066CDDC2AB434F6EF91640@SL2PR04MB3081.apcprd04.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39860400002)(189003)(199004)(7736002)(81166006)(50226002)(478600001)(8676002)(105586002)(8936002)(66066001)(81156014)(106356001)(1076003)(78486014)(305945005)(14454004)(71190400001)(71200400001)(2906002)(1511001)(36756003)(316002)(110136005)(54906003)(2501003)(2201001)(97736004)(6512007)(52116002)(6506007)(386003)(68736007)(14444005)(53936002)(44832011)(6436002)(6486002)(25786009)(2616005)(86362001)(486006)(476003)(4326008)(186003)(26005)(102836004)(6116002)(3846002)(99286004)(256004)(107886003)(55236004);DIR:OUT;SFP:1102;SCL:1;SRVR:SL2PR04MB3081;H:SL2PR04MB3323.apcprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: oneplus.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gzrSjnqTGsVAnhqe1tdFAfesnV4ccZDXA9iJSju8P4lpVqDSjSXk0wT2MrC1BPZRBS71M+ipLB+UfGTnsFDv+mucHJ+c3TGD+ODMNcFDAyoxZwZ95Rzr4TtvTTyc7/zRP4WThFwRf6HMbqA6waCeYQW9GdCWB4FogHjADyPtle0xar62ZbTVzGnXbgs7jbvn5mwtaX5d3ygAzthUKT/VNS8G03u/eVScK6/NzAL9rJeLCOzTgO1GJYBk7UiXBi8WGxBuckNkCulH8CxSlZ5E8skK3pm3ZH4zmSzckxS9Zcp386g1p1X/cJjSuyMnSYkh8BY44MWYggQv5W9Z6RIuD8q5TfpmcCVkGQ15juVGzVR0c9pM0yKISX1sLVgOY6h5ZTHkXsfGW/3+B87lMu6j+zGoXvteSquFnnaSPKfryzI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oneplus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c65014b-7e56-439f-13e6-08d6901ff8ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 12:53:50.0069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 0423909d-296c-463e-ab5c-e5853a518df8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR04MB3081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 4.14 kernel, observed following 2 BUG_ON(!PageLocked(page)) scenarios.
Both looks to be having similar cause.

Case: 1
[127823.176076] try_to_free_buffers+0xfc/0x108 (BUG_ON(), page lock was fre=
ed
                                               somehow)
[127823.176079] jbd2_journal_try_to_free_buffers+0x15c/0x194 (page lock was
                                              available till this function)
[127823.176083] ext4_releasepage+0xe0/0x110=20
[127823.176087] try_to_release_page+0x68/0x90 (page lock was available till
                                              this function)
[127823.176090] invalidate_inode_page+0x94/0xa8
[127823.176093] invalidate_mapping_pages_without_uidlru+0xec/0x1a4 (page lo=
ck
                                              taken here)
...
...

Case: 2
[<ffffff9547a82fb0>] el1_dbg+0x18
[<ffffff9547bfb544>] __remove_mapping+0x160  (BUG_ON(), page lock is not
                                             available. Some one might have
                                             free'd that.)
[<ffffff9547bfb3c8>] remove_mapping+0x28
[<ffffff9547bf8404>] invalidate_inode_page+0xa4
[<ffffff9547bf8bcc>] invalidate_mapping_pages+0xd4  (acquired the page lock=
)
[<ffffff9547c7f934>] inode_lru_isolate+0x128
[<ffffff9547c1b500>] __list_lru_walk_one+0x10c
[<ffffff9547c1b3e0>] list_lru_walk_one+0x58
[<ffffff9547c7f7d4>] prune_icache_sb+0x50
[<ffffff9547c64fbc>] super_cache_scan+0xfc
[<ffffff9547bfb17c>] shrink_slab+0x304
[<ffffff9547bffb38>] shrink_node+0x254
[<ffffff9547bfd4fc>] do_try_to_free_pages+0x144
[<ffffff9547bfd2d8>] try_to_free_pages+0x390
[<ffffff9547bebb80>] __alloc_pages_nodemask+0x940
[<ffffff9547becedc>] __get_free_pages+0x28
[<ffffff9547cd6870>] proc_pid_readlink+0x6c
[<ffffff9547c7075c>] vfs_readlink+0x124
[<ffffff9547c66374>] SyS_readlinkat+0xc8
[<ffffff9547a83818>] __sys_trace_return+0x0

Both the scenarios say that current stack tried taking page lock but got
released in meantime by someone else. There could be 2 possiblities here.

1) Someone trying to update page flags and due to race condition, PG_locked
   bit got cleared, unwantedly.
2) Someone else took the lock without checking if it is really locked or no=
t
   as there are explicit APIs to set PG_locked.

I didn't get traces of history for having PG_locked being set non-atomicall=
y.
I believe it could be because of performance reasons. Not sure though.

Chintan Pandya (2):
  page-flags: Make page lock operation atomic
  page-flags: Catch the double setter of page flags

 fs/cifs/file.c             | 8 ++++----
 fs/pipe.c                  | 2 +-
 include/linux/page-flags.h | 4 ++--
 include/linux/pagemap.h    | 6 +++---
 mm/filemap.c               | 4 ++--
 mm/khugepaged.c            | 2 +-
 mm/ksm.c                   | 2 +-
 mm/memory-failure.c        | 2 +-
 mm/memory.c                | 2 +-
 mm/migrate.c               | 2 +-
 mm/shmem.c                 | 6 +++---
 mm/swap_state.c            | 4 ++--
 mm/vmscan.c                | 2 +-
 13 files changed, 23 insertions(+), 23 deletions(-)

--=20
2.17.1

