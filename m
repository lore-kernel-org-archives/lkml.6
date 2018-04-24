Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx48qe9BdpsflVcUraoAadikOZQ+Ru7H3BlrNTONpRutZB5SrwZl2iATMCDkxpc9x6vXBE7Ms
ARC-Seal: i=1; a=rsa-sha256; t=1524572036; cv=none;
        d=google.com; s=arc-20160816;
        b=kOBMBruAj8VXZJd0RkJajv02y7UdmSJwgeeOQPVv+euuocot9xe5MWgRjQSaFgt77Q
         e/W3uByrofzcJnqMHVnq6W0v0H9x+4W+KMcqN8D/Oe89HTOsvranCTkZ+QG4AIAx8C4N
         b42RZacyvnvtzlegmwIM7hf/l5njoIaLTdMTzpSax+aITW74gebrKPHTqfDWB/+CGSkL
         /qYsxtimUERgKncgXQRaSU2blQAYvNgc2sq0vuPj1paSdSmbrKqHAM3DVeto77iHaF9b
         3bHLYPHN03qN9fDDXqRAi3FWAkP1EfUeOnmQqgEtVklek7kCXJilw5szrB5nlAIL/Ybc
         YPyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=uY8mc0UVEfREkBV6UN7W3K8AUTep55foxU96PqxY3kc=;
        b=kGcX68u3h3+OPrOLGo3UPEpUwh58OAKAuAxXVR+VUFF0xt/WtlklW1+HHrCUAn/N6/
         7fXWr+x7EF97ehsMMCZUBLUYkGfri2CHSjOhpNi3gYvHEK9JqtgN5v4aEhMzIlxLeLrg
         eiBvsiuwfWz2spYxACuy09MZ72De8jkkzMF5wFfa/QfitdrsqlcNAwo5b1IkPB2M7rqZ
         ZlNe1j1w+vElJJ8q0OqnQCWQ7Zga5Uk6bxJuzPYMR2JjLqQthIjwZfL3I/x6FhhVde33
         0kNQkLhcVqaO1YhD6TnikkjWMo2/r9bQWI0uKS6i+UlmMrmmtUv0ZWcP+7QbPHKKA8o6
         6kqA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=GH3Qb5bT;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.91 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=GH3Qb5bT;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.91 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v3 11/14] mm: Set bit in memcg shrinker bitmap on first
 list_lru item apearance
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
 viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
 linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
Date: Tue, 24 Apr 2018 15:13:48 +0300
Message-ID: <152457202894.22533.15760267773026304954.stgit@localhost.localdomain>
In-Reply-To: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
References: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0902CA0035.eurprd09.prod.outlook.com
 (2603:10a6:7:15::24) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:IPmPJe8Fp4EKvm85wFXhg1Sz2gN08CTGZNjwWzkT/bT2P+jV3zPO0Zft7U2Uod2UZze0lUfiTr2n6mzi4ZFOciuXNL9YptZDoaGERHZe/aNLq2lzCRVZvc0kDWRglJDZF8MBhXFTbJs89RvP1yKss/y6pVLJXDIFxeV8xf78Dq5GooAbLZVlmai9sAjnyHf2sJNlOpGWCMTxiZInZ2OEcBjaS5pIrSbf925ikosf+Z9yB7imiNFhzqD9BMB0xzpU;25:1MU8ozW1kKcJLKLR3UO/IO+NAL7TInYNbxVlyeslINdXFAORoLdwdCN6iVTMTwkqYh/M2qpvDhG1t4lD94K0khBXVbu0p47Wbr2EI8ADJCrbGUIpReKeptgYmkGxDzHpvU5VIGoxQlTlfIr/pcfIxCLmbiw17XOF609BtpxbginvfZ8vl7vDfb2Xr2bhiy4Yo8yrsSdJ+UUxe9tMWPzxU24zbg6PpqT72BIBNVMoy12pE/K9JunqMhaMdP5TpzU89EjlFS/fs8VsxTAZGn6O4U83KZRAPQ7m2Ev7hRizCBRZ0e91cqe7mmpQD/kzUulF/WYyIzYistybt9L75lqECg==;31:LgKcslqn5blxGa2sEErXaIgkp5V0tVZh6ilAzhsmGr5+yEEvOx8MSS3vhoK3dHhNm50stKE6GPtteSqKP681om/67u+DWUjY5pUEjzrMzvbK96o1LaD7HWbby9IBmzWX8OjuoQdhDRlNLFSnzqlSwdgPfAOXESlBu+Yu0zoqyVJN4lrDJQIj9Hke8ivsOFz3QloH3MrHf88XWXl5VchjXNhz/De+H9fAlzJr/JPbJMw=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:cYDknMR4qtL4/RvscAkQREBhTTMCIu3N5GyRN7/YUCE+YSQKPximER2awWlaSj7pUkuQx2Dd0W8ZAgzBMLPU47E8nS08fXcXT1P4BeZ9fZ3Pqr0F0a1gEtqUSPRsw2UHl8t1pJCshua5mSKuUjdPifIVGHwGFaLH3XVELUnEZ5Llea66KKWK/f39QQj1DVflzS7hX4E/l7WKFThKfRKSXjA8Sagbhwh2BDKwLJuzw0fZvnndLBCAQ/+NJLPVMPs7cve00ABKyc78QsfhSMlU+JCE2HjExpbnqLEiG+Gm3+jcJ0ehTG7A9m8wR63H9iB11bk7mqzIEXQ4PGnE05TfUq6gqw7kyB4LuhF5gOJEwgsKOCS2bHvBDTGuG6CNaCClSETudWQCW/mSpcv96ZEsnIwNveIS5PnWg4XrNH1jdEBISuWfh1ZPhQ/zGKM07UX88JGEx0OSgm9y7V3XNqwP1/RD8e7eTRH6vrhmCkS77oWIaeYWSflXoV+PELgWEn1Y;4:yz7TYO4TeCWwtx4ysssi7SIuOiYxWsoZrX1H6wQ45NdmfLwh4rd05kxlTCvhGLahhnZRZwkY1tIlSgre4e09AcXSnr7HMJL0G6ySZs81/+HCIF17ht8cRXHYTbOHS3wmz8B5B9rtDdz/wyiTcsrYxRm/3uVkw+wlmVInribRGy2GnepLQxIa3b598IebNsGvNBSPWHdownqA9FFUw3W7rUf3E9Xx/KixStXNUQjJaaCuU8aGH1CTWTpxtCPLGYMzN0ZAdQF5AnglCqxOXF02KA==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB133817E30DD56D0019099EEFCD880@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501410)(52105095)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(396003)(346002)(39850400004)(376002)(366004)(199004)(189003)(2486003)(59450400001)(103116003)(47776003)(478600001)(68736007)(386003)(39060400002)(6506007)(66066001)(58126008)(316002)(7416002)(9686003)(76176011)(52116002)(7696005)(2906002)(55016002)(53936002)(33896004)(25786009)(97736004)(81156014)(8936002)(8676002)(86362001)(106356001)(55236004)(5660300001)(61506002)(105586002)(305945005)(7736002)(81166006)(6116002)(230700001)(575784001)(3846002)(11346002)(26005)(16526019)(486006)(50466002)(956004)(6636002)(6666003)(476003)(23676004)(186003)(446003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6S2hQL2g5UzhFSFNHMWJYT1IwUkR2NFVj?=
 =?utf-8?B?aGhuNXdaK3hwMDMwMnlqdm5LQnBSMTZpbEgxTzZjbWZFRWJRQlpob0R1T1ZV?=
 =?utf-8?B?aVpxUHJ2TExvSWZLTEM1ZVRKc0RmcVFING1HUWFRemlUZW5LRVpqVjRNRml3?=
 =?utf-8?B?a0tXVmhGRXlpaStpVzMrUDNkLzhZZHZ2SU9XNllxNWdPUm5qdHd2ZE1ZYUtw?=
 =?utf-8?B?ZXB4SnBVSHJhNVNuSHZFbmdrY3crWG41Vit0MFcvZ1dLUVNCa041NlRCcEpY?=
 =?utf-8?B?em1yeVM3YjBMSng1dzMrWFF5a054U1NNeG43Ny9TU0JmTmlOT2svN0kyaFlH?=
 =?utf-8?B?aUtaR0gweFlSTVg4OGRFTEtvZ0R4cU55Q3I4c1ltOG1FeUxvMU1ZT2duUFZy?=
 =?utf-8?B?VEpJUVRLaGNRUzIxVTE3Z0d5OUhKL0I4dzVNTkxGVWFDSElzYXhrQjJpNWt1?=
 =?utf-8?B?ai9PbU5uNS9IOUtIWjhuT0J0dTBOTFA1VjVCNkwwSHU1Q0NUcE04clMzbXVB?=
 =?utf-8?B?YjdaR01FaXpEM2l6OWFFOUQ5bWhOcmMrcDJWdlh4VkRiK1JndUh0cjJIMUF0?=
 =?utf-8?B?bk1ENVVMdFZHN1BKVTFwL2R0TFN0dHI1UnRQazIrMGxodWJqWlA5enVzdUxC?=
 =?utf-8?B?c2NGVE9CaTR2NEpMamNOUlg0WkJJUFRyVlBtTkJoR1JOUEFGYzNZckZtZitO?=
 =?utf-8?B?YTRBbzFFNHNDSTZOOFgvNmdCQWpWQm4xM1BhN1pIR2swSCtUQkRVcFVhMVIz?=
 =?utf-8?B?a2VtQk5VY1ZTMWdvUjd5ajZvZ25BL285QUdXY28rVzh0ZGJVckJiQXBQakkr?=
 =?utf-8?B?aVIvQS9CQXd5N1J0V3ErcW1PeUZPdkJEZWluOW9jUzAvazhGK1Jpb3VEcXF1?=
 =?utf-8?B?ZmlKSVRpbS9IVXlNeXQxSWRGMFRra05zcmUzclVoOE40R2hqMXFrQkxQQ0Uz?=
 =?utf-8?B?Q1FScGZpWDA1TEs4dG9PVUYwT0dTTUdzZ3ozM2t0RCsyQ0xTRGc4eXBtQk5h?=
 =?utf-8?B?emxaT0IwT2dJTjFJQnRPQmtPZnRJSGNXUlVZS0x3WXlRY1hOVUpSQWtJTzIz?=
 =?utf-8?B?MFpkeXBuNUtCRDlra2V4TXpRM1FPdlFLbDA3Q0VBSTR2V0MyQi9sZGoxNThl?=
 =?utf-8?B?MFlTaDlYZ1B0czVZT0haQzJUWVI4WlhEM3NwUU1IbmJkbUZpdnFkZUc0K3Vo?=
 =?utf-8?B?a1BjT2lodTFJREtkcXMvdUZVaFVpbWlGdi9YQXdmbjBuMFYxSFBCVTcwcTFX?=
 =?utf-8?B?cnMwVG1MM3hwZWpPWEFhMmFnQUhpa09Odk1BditsRDZvK2F1dGlxdFVPRm9l?=
 =?utf-8?B?ZklPTktkN2g3Z3U3NkpZa0lFMkoxRDB4TklBNEYvNkNuaXQvTW5oK3FJbXQy?=
 =?utf-8?B?d0RkM3ZFeDlsYi9wNitERGhNd0F5bndxK3l2aU9uSmNXMzZLczlpd2YwQm1q?=
 =?utf-8?B?enFtSitxRkMyTXVzUERBSEZ5U3M1dzlHbVRUM2RXWEtDeDFJakx1YXFFaHdO?=
 =?utf-8?B?SmhyY0xHNnNnaGw2YmdjMEJ3aDdHeWZOSGJ4elZTNzZFWk02NXJickd3TGdP?=
 =?utf-8?B?aVpDbWJtYnZJcXd0MHVBVUFXWFZnMFpzMFI3SXJqaUdVaytOck9JSkhJYnNs?=
 =?utf-8?B?bmZoL1R5YW1xb2NtdFJNSmJwS3RYSUt4ZktGdlVWYXhnSW1CSEtFWUl1QmFB?=
 =?utf-8?B?UGZvRjhTNXhHajBDNzZmTGNxRnVjR2tOZzhQbDZ0U3A4dTl6OC93SDh3ZjRp?=
 =?utf-8?B?R0I2aU9SS09GQjhud3pRSHQ3NzB4WlYrTTAvNjA0SllPS0pxVjk0cEZleFdD?=
 =?utf-8?B?RDlwUTNmTEFhWWpiZXp5UmVnRXRTQnFxQUlyZVlOK1B1STAzbE9YNlRPOWth?=
 =?utf-8?Q?LU1wLSwIaKlVc=3D?=
X-Microsoft-Antispam-Message-Info: shJ6dDdXT/i6RzCNjPTJljRg8So2DMI5j4mWzraYXH3sGtVv+cZKoQpebD2clKNWh+1xLxia5JtS2RGmHULasvvJgnYVcEMwyjM+en0ajZUUo+Odno/uRBZIggLPvm1ZcOnO7CARemKsMUs2QANiaXdZMqh44QW/CX1SidlT1uEqTn8eaneJ7Ngte9Q0TuN2
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:uKgwyr+LuFx5PbLrTT9iYzAslt326jSshrXP/PdAeOd4fQRHIDQGovqntxQ4WvMa5IvYFgupB4hZY9FdWjgDz6z0g7O4x1Q4d9Rxj83uvguR4cd8AhbARTQc38tNfU8WgtpkNxUVfPnbnZKl9CLtQNQdu5+bOFXgVsAD9eaCJwiRiwevbse7WRk8sjaCfxuU55dJyHcW8Lxl05ei5/pLwEkS3vYtpEBaXPLFCvqaWvnQVtONVPLs/tdK+Vb9jsohdwi/aTL4C1piX3DdofvQ/mK0UN8W8/T7Ho+S2VDuWzrIHavGsmRf3uln1EEBrvMaYPEC8gUAj9Z9RvlvYz4S/tu4WULYB7mJAd2m0CjGsMAOvjjbvstlzYnLvhdiPZGsxUm//wHzrkAk0vURW4Q+iFo14/4M00biZrcdhDHsXBeuis71zz4vAXUirukjXBOR4Qpi63vly/9WKwsSDDGZzA==;5:rOApvalY+XFOys86xcHpxLzxLFT09I8i1eT05lgeFoVtmMxacjHGzDnf3GfQCSSwR3AyFJ/aXRbyAsTqpIkxCj7b4GUB2Plcr80Y9I9Dwn+gi4bpj9cakXpwQUozIT3rKTuj+lEZGZOxNWmRGzTwUAc4AKPX92rKOHltRozpij8=;24:/kWuBk7vAc+Ad0OeXCs/X1BQdx8npe1VIAMC3t+PZqRdh8nIbQvPxuzEnekN8dUH76s9yV6bRKrQHE5zI1g6EOqbLV+120kYDuJ5KXSlXik=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:rpilZ1AjHJsaYG8CmJHkOInUSZK4rE7ahTaY0kF+Pn2r/oLOcf3Fc8ntw5G/JB19kXGTOVV/mlkGc/7ZSLb3Cj+dowhPk7BDfb+P5Tzq78b+TnYJJQqOHi7gHDANr/p3X4BR5bKPvMOkkv/560pGkHLZYk5XdJN4Wn8psEE4sxxTUGD+mWonszarAcDIxoaT1xFg3CxQ0a/Yon23iyvNmYx7EMxUEJPf3yCD3TjN70mGFpSDLl1LSmP3FZAF3u1f;20:GMomtz62ow0FsHTyh4kEj7I6sTuY9KWk21bkKhGXTB3owFWY6jV+zRpTrGOBHMEeq3e6HuvPx7TtiHoP1qGEHtfKfJDNC5huS2WIAfyH/TSpiZwFh8J6bKkMD9I5dBN2Gc5n9p1z2QruMKsXxy0R702ji876hdSFspolAJvUemk=
X-MS-Office365-Filtering-Correlation-Id: 58dc4cb0-f315-412b-ff7d-08d5a9dcd7ac
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 12:13:51.0692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58dc4cb0-f315-412b-ff7d-08d5a9dcd7ac
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598629647950521236?=
X-GMAIL-MSGID: =?utf-8?q?1598629647950521236?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Introduce set_shrinker_bit() function to set shrinker-related
bit in memcg shrinker bitmap, and set the bit after the first
item is added and in case of reparenting destroyed memcg's items.

This will allow next patch to make shrinkers be called only,
in case of they have charged objects at the moment, and
to improve shrink_slab() performance.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/memcontrol.h |   13 +++++++++++++
 mm/list_lru.c              |   22 ++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 44c5da330c0f..4d5af7e399a3 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1243,6 +1243,17 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
 
 extern int memcg_expand_shrinker_maps(int old_id, int id);
 
+static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int nr)
+{
+	if (nr >= 0 && memcg && memcg != root_mem_cgroup) {
+		struct memcg_shrinker_map *map;
+
+		rcu_read_lock();
+		map = MEMCG_SHRINKER_MAP(memcg, nid);
+		set_bit(nr, map->map);
+		rcu_read_unlock();
+	}
+}
 #else
 #define for_each_memcg_cache_index(_idx)	\
 	for (; NULL; )
@@ -1265,6 +1276,8 @@ static inline void memcg_put_cache_ids(void)
 {
 }
 
+static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
+					  int node, int id) { }
 #endif /* CONFIG_MEMCG && !CONFIG_SLOB */
 
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/mm/list_lru.c b/mm/list_lru.c
index ed0f97b0c087..478567332746 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -30,6 +30,11 @@ static void list_lru_unregister(struct list_lru *lru)
 	list_del(&lru->list);
 	mutex_unlock(&list_lrus_mutex);
 }
+
+static int lru_shrinker_id(struct list_lru *lru)
+{
+	return lru->shrinker_id;
+}
 #else
 static void list_lru_register(struct list_lru *lru)
 {
@@ -38,6 +43,11 @@ static void list_lru_register(struct list_lru *lru)
 static void list_lru_unregister(struct list_lru *lru)
 {
 }
+
+static int lru_shrinker_id(struct list_lru *lru)
+{
+	return -1;
+}
 #endif /* CONFIG_MEMCG && !CONFIG_SLOB */
 
 #if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
@@ -121,13 +131,17 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 {
 	int nid = page_to_nid(virt_to_page(item));
 	struct list_lru_node *nlru = &lru->node[nid];
+	struct mem_cgroup *memcg;
 	struct list_lru_one *l;
 
 	spin_lock(&nlru->lock);
 	if (list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item, NULL);
+		l = list_lru_from_kmem(nlru, item, &memcg);
 		list_add_tail(item, &l->list);
-		l->nr_items++;
+		/* Set shrinker bit if the first element was added */
+		if (!l->nr_items++)
+			memcg_set_shrinker_bit(memcg, nid,
+					       lru_shrinker_id(lru));
 		nlru->nr_items++;
 		spin_unlock(&nlru->lock);
 		return true;
@@ -522,6 +536,7 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
+	bool set;
 
 	/*
 	 * Since list_lru_{add,del} may be called under an IRQ-safe lock,
@@ -533,7 +548,10 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	dst = list_lru_from_memcg_idx(nlru, dst_idx);
 
 	list_splice_init(&src->list, &dst->list);
+	set = (!dst->nr_items && src->nr_items);
 	dst->nr_items += src->nr_items;
+	if (set)
+		memcg_set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
 	src->nr_items = 0;
 
 	spin_unlock_irq(&nlru->lock);
