Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AEBC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B205208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Uaop2ZVU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B205208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936208AbeFRJrE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:47:04 -0400
Received: from mail-he1eur01on0096.outbound.protection.outlook.com ([104.47.0.96]:27136
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935855AbeFRJrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkM6HJZriRD5llvcLxaGa/KX3m1UjFJPmBp/NjAzqvY=;
 b=Uaop2ZVUnUNt2lvwaQxBNN72sNJei1EWVf/8W8qj/DIKBsZtqhxpOXXzBjOThhTnGRj3ixImmRnrNhrXzBNSw+JaLR5oKBr7d2yNmFp2J2D8keqAfvHJ1BqxfsQ59oYR06CVHreHGqQoZ6dtFWJjJgXUtb0X6gzNZ0V0WJLkH6U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (195.214.232.6) by
 DB6PR0801MB1333.eurprd08.prod.outlook.com (2603:10a6:4:a::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.14; Mon, 18 Jun 2018 09:46:54 +0000
Subject: [PATCH v7 REBASED 12/17] mm: Export mem_cgroup_is_root()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com
Date:   Mon, 18 Jun 2018 12:46:50 +0300
Message-ID: <152931521067.28457.1399177856448274667.stgit@localhost.localdomain>
In-Reply-To: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
References: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0701CA0070.eurprd07.prod.outlook.com
 (2603:10a6:3:64::14) To DB6PR0801MB1333.eurprd08.prod.outlook.com
 (2603:10a6:4:a::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6de9c5b3-bd89-4f5a-1aca-08d5d5006dc3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1333;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;3:A6Qz1ZnPkYxlob0N5T71EY7tSTXE+2K34oR5vhNql2ag8N/6/W84cy+8u21KlSyoz11JvX+Jb2vbl+ksOaweLoVrZ/W0S1Ch3lutp6vLG/tOSBBbIPcskAyBGuR9CWDxaoCioB8K54dC0PDo1HOQMkf68Y0H2xVc8ri07T+BNSBM4aO7r37nmCUMtbvqkJn3iIHKAXT88p/f4wHvUvFC6Y2QW3bFDdUsQ+PLg9hmY31JOc+0qm4pN2dMqoBcglEU;25:jx2LvvemEXlcT4ql9recfK8FhWxZpN+JRaw5v/50w99jNWLW7A09bGu04Ky/Csq/Uk7wotmdrz7GMM73197UoWINENJMIf/lHndOovsZfCgnPDzVE/O0faVFNDTknhA45pwZ90GhqQvSFn3BoCQMtnkQfdHL3Ni1Qlo+hhE+U2YzBS25vG2ELBylyV8FEDBc4n0Asnrx1WqTyaM4XGSGjUA/VWRFZX8E1iR2sk0e7tV6RPp8zTKNxMBQ2pIlWEki+5usVnLjbDnFLJkW5ZmRqi+Nz6EF5nqcoylI4NiyZtK8c4rbU/F2bC+r2BqGbc/xV4kDPFw/M4PwF9qy9GwHPQ==;31:v4U9YhwbbOzoGDrjtYtnDdNTNgTAsDhk/d1Fl9Nv6OZI4ICNgtKMUU/bcCPoHgXFaMr0OPGa6cqQJ9A3jSEFkJB6042qeHrj2DxHa/Pht/4hD2wjumtTF051AE1M5FQCClbZocdP2SCFkv2vie0BcVfPbu3Ixd3VOaBYxM8a8XeOCB2seiJIJBFPz9wmYprA+Nhw+3cq0JLoukEZZjYcra+zMTLPkRgb6qILPn1umaw=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1333:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;20:XtcyxCeLKXvrWTOoHk2C02+7Vr50fm98yOyhipKXj0Iu0Q24vtawTZKnXy2wPxcil0tQWXMtCnPFr9Y6cskwbt7vqX+4snk2N2ZjgSyyem0CNeZxapwJJ3Shl0Omx7EDIzjgxvTfYFPtkJ/bHVFsYkHC41AVL2v4Mux+SlvaUYlBsWR0o2ZGE3o9xokOZTCfl+U4TMSdo+dEvQwRKANJ/HRCjN1aalHcy7jc7W2lcrW2pMVcQ6HsC0yXejwVvhx2LrhGFqswtu5Bn0ZEPYV3hlXWDqPgA1vc7LmrK4ovohwrg4fsptQfboVq2LSmjOBWevf3CuRETmkSflIDfzeZKUwKshJxd7YxPoW0G9ha6cI2QlF2KacTMjTMQ9rmMmC02WFtaxTIFuNFlHq0UuVIngJelR7pp9g0h877iVQxF5Xw6+WBUmGq9YRECJYJvQtHBYxjjm/TX9hqF43sDckm7/TmoD47mSFWQf/lgV4Gedvjy6eJ3zLGT3Zb16f3EHH4;4:ErUDxvq4AO+1Q02Y33GqYZz1oEF/xKhkteJVMamzU5+4YC0S4GJBvV7qTcxHT2bhIzOYL6Xg+UjA0peAN53oeOMwZHau2mDXSu8uG/204Z9mdMktQhkpPHTAhlyrPHRsVgyDrrm+JAnaJRG3npiCa4ws867yjGIURf2DyO72MOT3ZSt+YFFgcFT5OLmWRpvt9UDpKtC2l6GczIF5RhZA0viVM9vHAwkoGe7KxVRoNjOnlwNudz70FYF/6N/vMawHJomlgLkEeRncvEUKHe0swlZ3LwhbD0+CjN3QmMRRaRrCnGviviqpPwG+VlOwaqnj5iumfC+PvA7pm3WjBRWpi9og77EUHrgHkuRX9di+SGkulutavY+E1hy47GzWoWnz
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13336D644EFFC4108948A518CD710@DB6PR0801MB1333.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1333;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1333;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(396003)(39840400004)(376002)(346002)(39380400002)(199004)(189003)(55236004)(26005)(7416002)(305945005)(97736004)(47776003)(66066001)(53936002)(25786009)(478600001)(8936002)(5660300001)(8676002)(9686003)(6666003)(59450400001)(6506007)(2906002)(386003)(103116003)(230700001)(16526019)(7736002)(186003)(6636002)(81156014)(81166006)(61506002)(33896004)(486006)(316002)(6116002)(68736007)(58126008)(76176011)(39060400002)(23676004)(55016002)(476003)(50466002)(52116002)(86362001)(2486003)(105586002)(3846002)(106356001)(956004)(446003)(11346002)(7696005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1333;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzM7MjM6R0ZaR2JMTmRWa0U4azZDdys2enFSbUky?=
 =?utf-8?B?QVVKejR6WGxFVUU5Um8yMDh6UGEraGNsTmNrVDZISXdvWVVFTWJkZzVWa1Rm?=
 =?utf-8?B?YzFwYzBlczRWODFnUTVXc2tFS2JOWDJRMk5ERUJNTHV6S3Q2WERqMjNubmow?=
 =?utf-8?B?Q01VY2w2UEt4WEV6NXRXYkoyOFhFbDBhVFVPUjlDK0EyK1JiaWwyTERSc1U2?=
 =?utf-8?B?cFgvdmh0dld0c1Vqb3ZUeTJRRWdGWEYzWmpoRlhUcjZ4Q0g2Q2c1SGNmRUF3?=
 =?utf-8?B?ZWN5OHJTaUJQNytiUzNuWVRvRVJIMXJLcVdVbTdNRTVxTVVDYm9jbUtMakdo?=
 =?utf-8?B?bk44eDBzRUd5dURVSGdCK3lHVE8xbVUrcGNxR0dtMFRncnFTVWZWRzZDa0c4?=
 =?utf-8?B?UW5kMDRpWHVmT2tnSDl6TzM5V0svUVJDNjhsa2s1cElmV1J6SWVhSjI5WTVR?=
 =?utf-8?B?dkVWOE5zOHhtU3ArTU9iVlVKZ0hPbU1rd1JOb2JhKzcxaU9vNGZVd3JOMXQ5?=
 =?utf-8?B?RmJERXV5MnU4cTUyYkdXd0ZiWWdrYTFvRGVySWhSaWx5bWV0MEtsdFdmNVJ5?=
 =?utf-8?B?R2dkVitHUzZlSlBwZFgrWklveXltYkNwN0hOclNLcm9PWkpNb1VaaTJPdXFQ?=
 =?utf-8?B?Nm5sYXh5VC9mRmh0ZTZVWThIZUZkYmZsSi9VUGNLaGtsNWxSd05MRUhqSDhM?=
 =?utf-8?B?NzJsV3o4WnNMQzhKRC9MUW9BODAyUnVFVW80TGgwYWNSSmRleVdrNnpLY2lw?=
 =?utf-8?B?am9iWGN3dWh0MUswSTlocGVrM2Qxc01VZ2JXbFczN2JvM1ozOVUrbExZWm5p?=
 =?utf-8?B?THpwMTVnOFl4RmdhdVdpYVpxbmtZSzUxUkFZWmVKUHVBaFhmNlBuUXRnUWFU?=
 =?utf-8?B?a0N2RHBhNXdzd0p2YkEwV0Fabk45Q0RPYlZXejlEZmF2cTNHaDZ2dWhiMTlY?=
 =?utf-8?B?ZTBXZk5FK1hRZFZkS1BBaW5zd1g4aUFVQWd4Q1dFc3FvVmVHR1ViOG5kVFFC?=
 =?utf-8?B?OGYrSmkxRkFGYXJRUURwZU5Rdm1UNy9vdjNMek5RVTczNXI2NldnSEZSZXdP?=
 =?utf-8?B?NlB2Qm1jaGwraHJRRkxQSitjc25NRGVBelE3K0Q5dTVZOTNaRURoUVJFdm5j?=
 =?utf-8?B?UnZhSG1ic1dXRndMTkVnbUVCYjRCUHpUR1U5R1RGVVRTY0M3QTdPQVpPQTR5?=
 =?utf-8?B?UUlQUlJrak5MZlRzeW0yV0dHOXZaUmhYZzA0TXEvbkswTmRMdjRITVNTamQv?=
 =?utf-8?B?c2oxNTI3cFZKb1lSa1A1cjhwb1NCQkRMTDhzbW9ITm44OVNkTG5wcUVMbHJp?=
 =?utf-8?B?QTRsckJ1d0hubmpHVm5ZMTc0cG9LQ01kRDhkQVN3ejhPWFJxRHQwd2F3a1Jq?=
 =?utf-8?B?WUEvNmVLYTVCakxrTW0vSzEwRXcrQzNWVWgrUzFSUlcxbGY0UXprU3dJdjRK?=
 =?utf-8?B?UVAvL3AzT2FDM2d1aXZ1R0N2dysxNHFqUGtRa0FGMGQvdHRtM08wcVBpQ0JW?=
 =?utf-8?B?R2VEazhFYXJXOUIwVWh2ODl1M1M3Yi9tcGRjNURIRXU5VE5wcDM5UzNEaEhh?=
 =?utf-8?B?SmJGT0Y0VnVpOE94TTJjOHB4S3EyTFFETkg5YW85U0VLM3pjenNPdVN5UDZz?=
 =?utf-8?B?YmlFMndtYVh4eHhSS3VWOU1UZm0zVnpxcktBTGhXOVlpQ095YjhjbzNnc0d4?=
 =?utf-8?B?NnNNOVFEYkU0UzhPYmpTbGQwU0RiaUFtSVlEVEdtOS9ySVRlVjdGZ3VoeFFw?=
 =?utf-8?B?Sms5RlV4NE5CWmdDVlhnMUQ4TDZqc29JdE5LNFViYnJONUdOUGlyRVVrY214?=
 =?utf-8?B?UC84dDRJQ2I5cWdWck42aWhhdFNJL1VnNXEyTjJkY2JpWkVTZz09?=
X-Microsoft-Antispam-Message-Info: 29Fb+q/wvSeA/tEtOb+KoXOpwF4TqtFHVjlgi7dItRmon3O+L53+uPj88pGMyE6vAFLsyGYDV5xx0Cca5vDYEf0MiTCspYZG/IVmfMhUIrodLusqTQp8h9MjUg8bnCsCLic+R5Uu/gOr2bJ6i2sQo1AabE3X4NuUTPfigM5TkaKuWTpBE10ayRdR+cKriMDbCcUj7Wu58FkyBIdJZORSNCMjWfWNYxNE91nbMKoYX3Q4b3y27taF6sPEZUphVisXnetCzNlFDiQ+t2B9eDllpmzpa4ZuCjs9ByhdY4V0GDgW7Z7MO1LGh1D+iMB3hA+JeNuVRrfgBcCo4LU+d0Qzjg==
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;6:7t1o3NnS5rdCOw0I3InzScz9/VZPIUo1KnyAmg87zMeHm69nSKuMrwNYAyO8QGsaK3qp2u/8bX1N2+n5QjDO9QkAJ0dhJ4JQKk9LkF3F2k6K7Vo2yFzAkIx0U2k9TAKFB/PMFrc7DzEFKqYN9pKe/0PYb27pKKKs952lBropTz4a+RFthHtCIUOGBraUsgdG4JoTR/0kLImUl32wCjwt9yv2eY7rJJ62hswOFnZ79/JFenEmxY5rU0EUxhD2X5O8I6r4TfHOkUe2Ii6ADO35NmHaBV67Ja61rLZt4mCGYfftOi577WrTzsYE7umIXEt1eqBjgYd4ZcoAdVdVmPcyGUA8AkUmbwGYmOINZDoRMQXOAUP+8qqiJ+cxoANv/xJoEoG4JWcqxqrZ9OSrHp79F4md+MCSx1eDF8/PSM06a/4J6UdIMNS9oBf0Eq4ONytDzBk6RCAyivq6IOoZvQJ4xQ==;5:/wsBvYBXRe/7PZaWWAmDzQPGVr7pLa2Uz0LTah9T7NfalWg2W/2LnjDoChuHQuGeALEAXuRL5cnRTTKkRvB5luD4KQ4jaPq1C5KramnAA+ldcyUDA5YA/wNivpIDF11ernHxAeQW3o1xzNkVugZ8OzYxKT1KW7VMyJKtwilS7NM=;24:ZGJ7BZ+8Mh3UrKIFpSjYVjrslGTMeZYH0ksF/5AR2UiFYAyxe6dIXScQMJdqj0mRIh2f3NXop479ccXjrfzMW0/L2yv+mK25gtG+UECe+XI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;7:7zSbX6GHrxHtDwDgQTZTf86NrKrtvFD5kT1aDvoRsBFs11CBidz/VzP4ZPJ8lUg/muqKqtqz0vvpoy/SUSImv3GcMPKgkruaSXPVeXrhbKzzyGA8FgtIoqXMOrqgyPzIp0sd3loLsV8OSXQFgEW/ok6mEf29o/LuClEvbuSd9NxwVJUwaQDSMErV7DES1TGF2AteoyusN9mkD4pyaLUU/tfxjtScdvJST+Yj/zcylVISnFNl7dFerOILGJ4oXOqm;20:qoKUEONLmSxtxnVlj88zOTXbRCZ/LTl/Ge7H6qytwkkbwUXhO2j511m0Igec/h599DFfxhgMe5mZWsFbFiIYPhQtmc3RSeN4qhksiR/XRF5xgWeFbCo+pSyFMse12L72aAMh/Hz6TgiQieEUO4Y7wilykryYA0wBfefILKnCjCU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 09:46:54.1326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de9c5b3-bd89-4f5a-1aca-08d5d5006dc3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1333
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be used in next patch.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h |   10 ++++++++++
 mm/memcontrol.c            |    5 -----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 40401a73000e..7ef004c4f4af 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -318,6 +318,11 @@ struct mem_cgroup {
 
 extern struct mem_cgroup *root_mem_cgroup;
 
+static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
+{
+	return (memcg == root_mem_cgroup);
+}
+
 static inline bool mem_cgroup_disabled(void)
 {
 	return !cgroup_subsys_enabled(memory_cgrp_subsys);
@@ -771,6 +776,11 @@ void mem_cgroup_split_huge_fixup(struct page *head);
 
 struct mem_cgroup;
 
+static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
+{
+	return true;
+}
+
 static inline bool mem_cgroup_disabled(void)
 {
 	return true;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2b703c4130bb..a122572c0219 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -261,11 +261,6 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
 	return &container_of(vmpr, struct mem_cgroup, vmpressure)->css;
 }
 
-static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
-{
-	return (memcg == root_mem_cgroup);
-}
-
 #ifdef CONFIG_MEMCG_KMEM
 /*
  * This will be the memcg's index in each cache's ->memcg_params.memcg_caches.

