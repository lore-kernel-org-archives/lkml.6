Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA57C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 08:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9848C208A6
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 08:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="XswKs+G7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9848C208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753872AbeGHINA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 04:13:00 -0400
Received: from mail-eopbgr70045.outbound.protection.outlook.com ([40.107.7.45]:51952
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752901AbeGHIM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 04:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ok52Jj0hRJEZlC7Z/+UdIqcI53bD5Wi9vAZTEwtYTao=;
 b=XswKs+G7Vkzdz7ZS4LLIXshRrkScYpqOWIAslQCXqsbEMQ3Kbn+Dlm8D9cJ06geFNvu3+d+PWNcDhrPzWkcEoTDpf4VTxY30A+cJYPDF71hKVuhktKEztn2WsJU/aLR5sdJEo6ha4uf9mz287d/ct9EcPCnZQE1j4UGOWag3puU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com; 
Received: from [10.8.0.51] (193.47.165.251) by
 VI1PR05MB3262.eurprd05.prod.outlook.com (2603:10a6:802:1c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Sun, 8 Jul 2018 08:12:53 +0000
Subject: Re: [PATCH] net/mlx5: Use 2-factor allocator calls
To:     David Miller <davem@davemloft.net>
Cc:     Leon Romanovsky <leon@kernel.org>, keescook@chromium.org,
        saeedm@mellanox.com, vadimp@mellanox.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180704172847.GA33621@beast>
 <20180707.201553.20530216509400327.davem@davemloft.net>
 <20180708080652.GN3014@mtr-leonro.mtl.com>
From:   Tariq Toukan <tariqt@mellanox.com>
Message-ID: <499cb83a-c187-d49d-e446-bb7dc522e98a@mellanox.com>
Date:   Sun, 8 Jul 2018 11:12:47 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180708080652.GN3014@mtr-leonro.mtl.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: LO2P265CA0072.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::36) To VI1PR05MB3262.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57deffe8-18a3-427c-8cc1-08d5e4aa9b0c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB3262;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB3262;3:K44MkB5/GrVPd154vECeV5KZFYGlU0otjJQE0OwUXD8cIcXVW7DlniSX+k0Kl5u12TpqbxMF4he5QQzdU308E0taRlf5jV1L6kODAjQuOCPtM+Ot0qI8UhXOvmROIZ0dr6T7FPijdmV2HIX5lJxQIIrTRexQRYkefQS8+RIHFcmmArO56zeu7rj/bq1o4yYwLJdHYRjX2w99RpCc9BNTx9P9rzEzIt+Hk35l3Laxr0jcD3LE+ucaPcSfJP1ViPlI;25:nMsEOjNbvas3V2EDmbMhrOFzkeiSA+e7+DK/CyWmIoWc+ZK5jQBhYOHtrsvST2H6uDo2YLMOs1dsze/CCo5wC1h0jTDdQVE2dNOKURthz/7gpO5qorV+EoSKRoSlniMFPCeVLYiWvkwDpJ2PTQyVC497pQfSEDYbJebnSsRd8y8M96jsNc8LZ/Sx47GZLa11Z4/kHLZ/n28Ipij2WjWuCV5wwDtnBrv4S2O2NOixqckd3gMJNF7//i3R68IUyMV9bLdPE8YM9OpZVI9LELKbIYpm3e7tCt/wjRW7P/qznf3SIcdnogVrUygL2yEET/n13UAr70E6ED62rYHLqEjCsw==;31:bX/GjTsxGmZnoZxKfkKgsVot0iL0NR8VRgUOYAjLbu8+JyHW91CVu7AgW7iKV+1IPngN8Cf6xn0z9DvWz3pVCD+2GMwwly8W3VQS7l1GQPqIcSR7lESPvROHC7fQr3GTUebp3F1Mnnx7oCdrdpA4efYVpknSEdLCr4ttdhEEmmql6sCM7agpk9Q+GbbSGPg494IlsKobpyyF/1NPP0lQpqndMpZn3cVNlBAIXkoJrNc=
X-MS-TrafficTypeDiagnostic: VI1PR05MB3262:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB3262;20:viF8dbUUPnhs7p40ruYPQJK9iWrgNQKLIWeQB98MjTr7u+V9iRbALQv0BvVZNuoJL0UDExeuoH2x91ON+2/DDUE5EPMrqp+z6MzzC9hTlRaJth67f5vm3/Okz2vxfnsCbLBoiHzO4lV6BlSoo1RlEcTV3YXFKeNXyClhhshR4bH6ymA985G8soHYLLi0H+7+I0fyRaKKq1ycYmypOUellVP1KUblRUHoZp1kl88nsjsDoMUKNUnQ8uxJ/eNt8nCAxfryxPWfxYWkDiNxJo+0MMEZmvNzn1iezXgUDmZC1R2eRya0/BkXkVER9wFCktOWW0n4cGSKoCIxVRZgwvLJeMJsVxl6NE0vUTTsPzptwwC0Zc2NnI6CFjC0hDtQOeDaMUlKWTxpxSrnQHSfplkNnGSW91knp5LULrZDt/gO4Qdx8G1LrXOelffJsTGI7A19PbBssvq+MutuIl35Xesj4eJDnFi1Djyukd3xk7tm63zydLlVGXTCGfDGxpdyb4J8;4:jFZ8UOojhIZJ4fxQikYee6i7ATMF5z6eXSX0hIhs82/zehq9WFfx6629DdSziWBPHJBM+ewHeUjvI2Ym2b6nZFrzYgyRgIYZyMd2zKiZWLVzRKPORXBxGmoW1rN1gj1N3vMCpO73I4pJgGZjSuQMWiQcr+vmtpJz1mErpDYduVS961056GOTWT9RTaYYs2+2bqy0emghN7aM9AJJsWnPmKWWWRIwpZ+nmpxBMMsUOrPHNRbx0uTE2DGDazoObQxOtDRyu/mxIdQ2iAD/yPzB+A==
X-Microsoft-Antispam-PRVS: <VI1PR05MB326277C3F32664A260B1600FAE450@VI1PR05MB3262.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR05MB3262;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB3262;
X-Forefront-PRVS: 0727122FC6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39850400004)(136003)(396003)(376002)(366004)(346002)(199004)(189003)(67846002)(97736004)(47776003)(23746002)(956004)(64126003)(16526019)(16576012)(186003)(386003)(316002)(53546011)(77096007)(26005)(65826007)(229853002)(2906002)(2616005)(476003)(58126008)(76176011)(8936002)(65806001)(6916009)(5660300001)(305945005)(6666003)(65956001)(52116002)(36756003)(11346002)(446003)(66066001)(105586002)(486006)(4326008)(7736002)(86362001)(81166006)(81156014)(6486002)(6246003)(53936002)(478600001)(68736007)(8676002)(3846002)(25786009)(31696002)(106356001)(31686004)(50466002)(230700001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3262;H:[10.8.0.51];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;VI1PR05MB3262;23:ob7xUsc6aTMi4ytUehFoWYt5isVx/+6Q3C441?=
 =?Windows-1252?Q?QV3/iLMtqBvbc99jRymbHFpZOSSCHnQiF3mQrkxJuQdDY0cyx4NuPofJ?=
 =?Windows-1252?Q?8uZebMjJo/qyhLK82bRlxzUqLyALxQyo7LV5su5IblThpeXcl9yjvxQI?=
 =?Windows-1252?Q?UdqSfaNUDkSLizNXBDsZlg+mkYUgMVg7DzVr6m+nBCcdAvkB8EDRmbr8?=
 =?Windows-1252?Q?2IXLq/Ns/GloCPdCPEmvWXs3OPbNfnXjFDbk8qBpHk/QrcUwiR4oyWde?=
 =?Windows-1252?Q?vJZPruxn55LwbTPUaYYloPDrE5U3L0ANdrM0TChCsEWEStPoiirIpBLp?=
 =?Windows-1252?Q?rcORuCN6O0Oe97rvDWle5/NKYk4arUvBkOD4F0znOqB9+QC4F+2ySGHi?=
 =?Windows-1252?Q?tC+b0c+ilUI6VQz0BPGnoSppzIfJYs/nm574207RT5w9JFFZZQDYrOwn?=
 =?Windows-1252?Q?KbBpjh6pCTyl79COuEBWOBXuPTdT9VztSZ9sK7ewR1l4WiGLfZEN9K2J?=
 =?Windows-1252?Q?EX9IMMbMpsMVdOX/N+J30SBTZgmMTVK5SJi1yoGrsCmMLtZzGoS9kctQ?=
 =?Windows-1252?Q?ZbUTDewVXaSAMUsOaNxdh4QahjYLP6fsEpq5rvRTw6W0Wrdl+GbnU54a?=
 =?Windows-1252?Q?4qgksXg6Nf3XHEIhAwWX+X/5QcIzZSeOD1w+eCzMByfiormm7DTreW/c?=
 =?Windows-1252?Q?mhihbG6h/qEodbr2BA+fXfLvGolNNHUs4j/H6WgB4XBwE+uh9FBPxrKr?=
 =?Windows-1252?Q?vm8B/d5FBTfIv1SnSB63d/Fi1QocfzOqGUoG9GFFNuDTaO4cOBaJ22FX?=
 =?Windows-1252?Q?95VpLA/FHzt94nMj//hwo77YieWj2NsvBjEKHlQuQOT1rpsT8WNYD3ot?=
 =?Windows-1252?Q?kV2V/7qBr2MBs3BtuozeIabW9y4peYcKYrMTo8yJ/6nO+EXUWwlfA33z?=
 =?Windows-1252?Q?FoolIcOO3zSBvdV4eA1ybxY22Fl1yytg97V/vSjjWMa9HyZYvaQLWM/8?=
 =?Windows-1252?Q?uqCJdFAPOpTJzb9XYDlkNkerNJkdeOaHXgCotvUxK8foEKSjqPYYRy3b?=
 =?Windows-1252?Q?h92u6O3may7WbnFsCupvaFGCxMNBMVAd+iStTJmVtRkr1+7wHt7jkLZZ?=
 =?Windows-1252?Q?IAnIRDhT15hpYumizYLCY/x6Jp7F5DRRoHlcFuMaug1g6kWv2yyKVkjz?=
 =?Windows-1252?Q?VLUMz06LJtO8MThK/NZsC+DMDd5JGL8HddKJDtnnUso89dROCgtwJc5X?=
 =?Windows-1252?Q?ySMb/8QhU+e5iWUOZXfW+/KYt65Ly8N7aEhGuXc/Ug1jkH7fuyx5B6qv?=
 =?Windows-1252?Q?iCVYcB8Dy4p98FqyVEelD6I33dcNNgqNMFc/7OnEZKJMzlJFELGn3amD?=
 =?Windows-1252?Q?sElHspzZY+XiO244mcdkNhA3dKLj7mRR9s+K/4Fdd19RizwAffGQ3y/H?=
 =?Windows-1252?Q?ggCNcBqUgKHplzn8PpZh1s2EjOB9OelGbTP1e3aix3UwXDVKMyWtq2e+?=
 =?Windows-1252?Q?lycPT8=3D?=
X-Microsoft-Antispam-Message-Info: jsJTY37asSKyGpP+QKyTnKJ6iTZ5X0sXLL0P6Vk75sd134C5cQvpZK7bN2rmP7HqFY5PASjI0OXxdGiJVlLdNqbOJ48T3/Zj0hfsz+ui3vQVa00bCLZ5NhdwPKELENMJB80wW/NukgNoW21CLwHRygTPNnTpGvae361LMDt1ZumZl3DLANfZXortt3DG3QcUfpQBtpcpnUDyO9F/bWd+MFrr9CcBZysNg59c/aNe06/qxcVrSe+1GcQXUaqLZSfN1HFh84PO41qQ4lNuVHYTWSBo1ArvMdNq3pK9HwGk+YbsL/4naAAE4EJyYy95H1V5xQj6COoB2hgr4qo7P9Ki/RJ/jW/oBUiTbSnWK84lwyE=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB3262;6:TQUMe5rmWPuNlecBQVgNsm4KMXANdE6qPX8ut70NRocSPgjLA98ySGgobJrwJKNS5lcrZTqQfzCpIvxwVdYXSIkPvDfPRsaHRsKWczXdtAL1OP29Y82g6R6k9Nz6UYz1QHKmHjgyb5M0dyqHCCZjoPqnG+dpl05/wxoSSnTHdj6OHQ9Png0u1jZlOamY9THeGDSt717739lHGfNEsL1l+l7X4KO6WtWkrPNN56xC2bVRe85L8rm5WDcI3sU5+8S50Qqix3krDf8JJXDqCdVsPyUj+60LvkELd3RE/r6ExfJld6cQmH6ZnGTmIja7uadDIeD4xTfzx7Y12GhmlXvqIbIVMVuAvQNio2POBD67MaOXr3IS1Z5sjYlFNHTMg5BT4VAVFsZ2fOqI57HpCHfcoTAAb2Vhjlj9cW4nyJdToBc2UML8VPGN5/+SrSExat/zV1jAGufnLq8PIs0IdPrMDQ==;5:9nNPdgTEE5HPwfYO+0HubF1J3Oi/s7DSEwJeBipLinIcCb7nVMYbX07CPufky2vvcDG5mz/1dXISt9xv/v+TG4cFfPc5BSuvUoHWb57PmIFWSoOjSMEgOmhwieNsAbT12CuH8njID4IkaKEViAnj9j6VGOi790OT6XM9ZZNa7rY=;24:XHseC+GCDSHLE3NGLMgCOxr7i5RSN7y56AUcwIqtupnI39DMRJTfR6Ao+iwdHfzM1FGy21joxftsu9LXW2VmrNRlWGhW1mPdOe50nxtKr9k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB3262;7:EB+8jfiqesfjBv2i7CyHV1risOtXPLzxMT+B9SZNYL/13odjZTWqDSS2wl8NYHd6UJ3KdVM7W6mX4JpMk4ZorCep35KTf1To+MLy8ZEecW+nDL9STqBC/XjGZ2OzyEuX4sAJUn0x9p5gWdY7steiW04n2CXrFs6H5g01ayGdKnXd1qowAk8YXrbtda/6Wk+bbWBkjcpMjDRbYScsc272/uyX2o7rL184B//tA0dRTJvDnJWa+0hxhMEoaMWMJVQi
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2018 08:12:53.1511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57deffe8-18a3-427c-8cc1-08d5e4aa9b0c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/07/2018 11:06 AM, Leon Romanovsky wrote:
> On Sat, Jul 07, 2018 at 08:15:53PM +0900, David Miller wrote:
>> From: Kees Cook <keescook@chromium.org>
>> Date: Wed, 4 Jul 2018 10:28:47 -0700
>>
>>> This restores the use of 2-factor allocation helpers that were already
>>> fixed treewide. Please do not use open-coded multiplication; prefer,
>>> instead, using 2-factor allocation helpers.
>>>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> Saeed and co., please review.
> 
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> 

Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
