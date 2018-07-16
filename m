Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB59ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E418020852
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Nryelbml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E418020852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbeGPQtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:49:03 -0400
Received: from mail-eopbgr40114.outbound.protection.outlook.com ([40.107.4.114]:45888
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727405AbeGPQtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLu229rcNxr0j4U84wvfUDTcVjjMcyCpkDrc4JhXeOw=;
 b=NryelbmlOJLO75WMNyLKr2Hx9VrTbg0yNoWEbUTLoJzvX6LsCnFdegcnFby9STWPROhDKGQ1WW0j/F0qGsqoJxowhqvBEHSAhNTFwoKFD5Ic0rSkUw3MkoDqdrDYXpPI0YlbYP4iZKjEkEncXt4fnUP05RvZk3yAJSaiAPjrM88=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jan.dakinevich@virtuozzo.com; 
Received: from localhost (185.231.240.5) by
 AM4PR08MB2769.eurprd08.prod.outlook.com (2603:10a6:205:d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Mon, 16 Jul 2018 16:19:57 +0000
Date:   Mon, 16 Jul 2018 19:19:53 +0300
From:   Jan Dakinevich <jan.dakinevich@virtuozzo.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        Alex Vesker <valex@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Feras Daoud <ferasda@mellanox.com>,
        Kees Cook <keescook@chromium.org>,
        Evgenii Smirnov <evgenii.smirnov@profitbricks.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Denis Lunev <den@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: Re: [PATCH] IPoIB: use kvzalloc to allocate an array of bucket
 pointers
Message-ID: <20180716191953.28b7821d@virtuozzo.com>
In-Reply-To: <1531144263-24717-1-git-send-email-jan.dakinevich@virtuozzo.com>
References: <1531144263-24717-1-git-send-email-jan.dakinevich@virtuozzo.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0PR0102CA0033.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:14::46) To AM4PR08MB2769.eurprd08.prod.outlook.com
 (2603:10a6:205:d::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6866b55b-9d3f-4a1f-efe0-08d5eb37f9b1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM4PR08MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2769;3:qXnhJXtaPXUdv5KAnxgmoV9CkK4+V0JJ7w0dWWf9kcqqkkPR8A+3g83jB1LIhHY2CX7Hm1eTIBapaN2dR/1nsKWLHs3ePdJ92YJAGWKr7edAfQ49KZ0okXgdAu9Zm2Nmo9+wKhbf13W6RLShD0jo+b5NOeSs+gzWpSWi6RW2oD8UuFzYWS4gJrdNZ35XYDMBcpkN3OyQrqriuQ0J35H6wh/sdVs+4xyqjdaNHDF9QocbiUcckcd1GpO9PMramJLb;25:4Vwhzwxj4s2Q3xvxo78SwwsLwuyFxo7XxxaehCDht0Z0FBOkI/dmVRQsX+/WVMfahA0T0lyRu3QnELCsLUT6U1GGTPNAMt6gJedShPCjJbbWdTRMzKY5MavXhUHGNMt7qfzP0iIOA4DA94/H2XEP+pTqegs3GGwsmxv+UjVhMj9VjZObBGreKoFc6lVoOhbk+Xjt+tqmWBjIr0VJhEAJh7Ibm/QxHll2OZfJhBzTx2A3qnKGbJWxD8g+d+gjQzz0cZJOWdq1/lBLH+SsQAQakmsDHebiOCBAYU4iEf61Rk1MwBnutRev/C/amnCn3DJLq/7gyto9IUa5o6Ucn761Rg==;31:SMRSlQ8r/FjB/h2gkc/bakMbTngiT9a50dYvqe0knbGRuXgR7j16eegr0j0KoGpPtEsgiGYc1nVaotjW3BD9vK7+lM9GW959sFBXDG3v1AtQ+iwW8PSylNozQYvPhhq39VHfO/1H+AYhAtEMVLIxXintkrbTp7PgoUPwzCEkZMPsEGHYlkSca883QquUJkjqNFLAmglUVkTGmGik+3iJH12TLgy4svTpPwOShDN8vkg=
X-MS-TrafficTypeDiagnostic: AM4PR08MB2769:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2769;20:JSZjawFnoNFY+YMoDUmELOQuX/Sr/KAi6NKQFS4tvSqnSCziQ17rVvWknvnVAw1iQDA5ctVSdxkbJpRvgu2fnP5Kjf7Fb0e2sl2rYLRfZ0gRDxsG1TQGwnAlrxxM2T/Aaao2VETu9XKqdOWCuZ4ht294MJLgUoKfi64/X8jT0FH75xtsKphetjCVVz6fb5ynvtmVF4FQlfMzkh8HqDzuYPI31rI8YXbFxSU211O+5mYLH3roo8aoVAxPpDdINmuCysCZkq1DHZORYZpMvET5mxjaWas7eJZ2VPPORf924kNllAS9Bzaem83iUOOLJQwpu/XYTDnGW9dPVhX64Zo0r6Np9MpiiDuvgGUeKy598r+sqNs/BrX8pQbJeKfY7xVOHQoGpELy48+bDdgwArmi2zh15CS9up7xlSTPQIrpWjdW2s4Q2tV3PUnHoO0f6TpaPPfpF3YKXu4FF13iaoNcIFTtnmfuVI1oMpmrzxQHqJ+xnOtfIx44YCD+HOPw2G3e;4:8PPHueYFdSXcjJvSn9L75eHqdGksIWx7+BrbeBadyhoVsREwN6KV/RnyjdvlHYmCYJjl5W/8n7olB7yTRnXwQnRZrFBA0a3MpKI4NRswdW6E7tYqwe/KJVJ9g3eyph+B+ruIuZRj3GR9bxJE26WjxfRH7RIlVaE9H6C+fMKEWC4HMtLOuhTc0etrPcQMNiHitUdV1/Er433aS+okZGdPeUyO4LQWhAjGeL8W3ho80fTBcxwcaIwnmHZyVFsgxpR+7AGt2ECOXu/2SfDUz+1Osg==
X-Microsoft-Antispam-PRVS: <AM4PR08MB276977845A5854D92208949C8A5D0@AM4PR08MB2769.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM4PR08MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR08MB2769;
X-Forefront-PRVS: 073515755F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(366004)(396003)(376002)(136003)(39850400004)(189003)(199004)(6496006)(6246003)(7736002)(305945005)(76506005)(1076002)(110136005)(54906003)(230700001)(105586002)(478600001)(23726003)(50466002)(316002)(106356001)(16526019)(446003)(26005)(186003)(52116002)(76176011)(50226002)(53936002)(68736007)(8936002)(97736004)(3846002)(6116002)(81166006)(14444005)(386003)(44832011)(7416002)(25786009)(486006)(8676002)(6486002)(4326008)(11346002)(229853002)(2906002)(2616005)(956004)(476003)(66066001)(36756003)(81156014)(6666003)(47776003)(107886003)(5660300001)(86362001)(921003)(39210200001)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR08MB2769;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR08MB2769;23:IuAx1VLfA6IBUQhE8IipsLNob5J1jRxhcthKr0M+1?=
 =?us-ascii?Q?QMTW4H5ozK1AjMNFcyGjptiJH18GBLkZQk2ThATrzMQR3U+cHpXxk8A9bjU2?=
 =?us-ascii?Q?QupX23zaKnX+635wXXD26GqUeDLuXHFhEYXpMEas4DR1nA4zR+UG6GtWzplF?=
 =?us-ascii?Q?m6OihDs5lpTSLKlWa6qx2h320sH+ujVrF1g5Uap3QUfebGWfp4hx7m2nHjhp?=
 =?us-ascii?Q?AQhvvuJmeJtOAuy11O730sZi5D8yz3AECfknziKNO97XI/O2zDkZ36Aya8Yw?=
 =?us-ascii?Q?SbDWMjfEtKCV5jwhfBZjOHxqzcmzgaEEVS2fmFhGYfw6MO+KEmVUqMW0q+0i?=
 =?us-ascii?Q?wojBZ1qQWx83wektmSn2Ltkc2aEsL/wOsotIHB8Rr4+xKaXfJtUNTysSOdfS?=
 =?us-ascii?Q?UO52emeBwPb0YZ5YYWa6FEhWXoEovkB+GQQuLRddkxTQFFi7aODS/szwX7Yv?=
 =?us-ascii?Q?nroShZs2WEtaYagRU65zENk+DIlvo1JLuUjFucNoHcLyd54CiY/ylpNP805b?=
 =?us-ascii?Q?ylq5P7IFhpl1IJu7eVqxb0WMDATVtJDucxWr90JGV6WF0vMTTwJRtwNq+7e2?=
 =?us-ascii?Q?bC37MlcQRpLsO8BW7a5Z+l5k7DSyGNrxJnQb84ieTMb/9CFQcvij8HTrsJJM?=
 =?us-ascii?Q?y6q0BwDI9UsN0gBRcpcX5WfjuXbjjjUFfGG8QYHaew2fGnzAm0tT5oCJ/s2f?=
 =?us-ascii?Q?Aln6bFcprqDKLHHtxfLCtux2CKIF1ywC1gsJTbmn/WoweW+Ew5+PPfRSvI31?=
 =?us-ascii?Q?4fLZOVW6z7XhTz0qRyRf74Apgn9Rfw1ySM6kFMMj+VT5jpzEFbS0uTrF1aXX?=
 =?us-ascii?Q?uZXnVTi88ThQSjBBqpmsKr24qijn9N7Y8v/J7USQvOeolF9zpsERLa8w6Rra?=
 =?us-ascii?Q?daxRBKXCL2WykGebNbhrubjgMb+zplr/J0078nxNSAVThMSF2RFZrcTeVbMV?=
 =?us-ascii?Q?XdoCyC5NNzydXDMJuNf8KvukYCd+jrLMRhvO0Js96XCbDgxYADheKkSUgHtM?=
 =?us-ascii?Q?qBb6tMd6Sod0HlQSXvdQyVz39/s6tqiCGSDvjGEXTggGXh5QUQV/EYDN0LQ7?=
 =?us-ascii?Q?Rs2mvOXLE6vxds6IkeeeNH/xZK8fyzsz4CIeqUS5mxUrQNTUztDwBAA8kq8w?=
 =?us-ascii?Q?5pVj0i7m8zZd76IIFDnyqngqEHl3p8EsFfKDvCuXQJ/4anQftXq/4iKoYrUu?=
 =?us-ascii?Q?eZk7nu3vl0v/Mt2+Fv6ICOLcKsRzY2+P54Jk3vOZml1Zy0BCy5QTidEoF0Vc?=
 =?us-ascii?Q?FIf8otO/rdbxEjKKui6+UUz93FfLLS6W6zksirIskR14m38xn58W/Q554ajx?=
 =?us-ascii?Q?WMETD+buiguPbsvwO3llNQ550x/N6V8cLK8gmAllI4rF7UBWQ6BcH6h9Ni1U?=
 =?us-ascii?Q?CAcqhY6pLdsnQUmifJMef3mz8qcEs5gOliy5lkIETk7QGt4?=
X-Microsoft-Antispam-Message-Info: TqiD05bqP/mZNmEQVuffV5CnY+3Z+i486ma6SzEaRzN71geT8iWUfUHc2FzRe9H1yUVl1p1tYavPcGOw/CtYncdBqgCotU2mICLO3CuvDOMsK1GCyZW34lNXJnOOwOKYjvwDkseCGvr2HbZJPPMnkCdaZhcS2vw/H3v7165l29Z5/jZtUEVBfs9Z4b11NjyP0bgsgfH+h+5NyxCaZTNmso4wYf13r+INjIxNY5OmcQPha5EiR1JDkc91HED3AobIr7r+P8YGfFH5bXY7rC666Ij+ZwDyzf3UL6oH+BY/MoPcGOBt2F7NS8oLAbcrSlsUA2kcDE/CdndzHQ7k46LH3sQl8VwcZ14JE9tKHM3UxjA=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2769;6:qIfwGje/cSzEgcsTvhZKuWq9W7EwzbDLSrm3pMEAH/Ts24hFsF2zAo2INnmDoZ0i3qHBdwBSqIBOPOMdcC+RYyb7gyx+dbt6EtiF4VQmxHQAjkic7vw/Et3rdDVGKwLFX7xq8BnjZr6KT35Kw51J+zXd/QD8+HmABVqbuyLl4esCB/mUbPKD64WBDDVAbgiR8i4ae25MW1+wGxmoUVhVpqFprmemKYJuWK7MLqMY7VPdU9hF+4jXP3PKy3S3IbO0kvkuVS1DsUqFGLFIoHWwMbVeDirU45XXiMbVDnj6aQLXqyBbD7Hol/3gsfFzqOyVXxPeTD7SdiUIF6Lf2cKcpCb1dXDyGhVuJbi0p4AlcUr6YZDJmcw8Tkd8Ul1MZlFRymiwxg2Hhfmmh41fAZQ4PMtiwLXpOUMrb560RMXTpU29u6Y94yDv331kG+ouQdRtkbIq/BI96OE0e08Ab8gGWw==;5:qEeWXzEWT0aP8VPWzS4xdP33to++oSVifaqXeNBGa4WEEeeKR5/4/SgU932gf7gXjCxojjAuhYLB3heYevNItPURxv3gZL7WQCUUMKnICem02Hrz1gBfoQg4DJsEuLHVPXfV1cQ5qGgPQ9ab8zneB9FjDw7g9r3v4snYvcQHT84=;24:KPFY9R3fdQK6wPHrhATyk8sh1W1D9G2JZlZFQB+rIFg0Y7h+SSOTUDNhpemd3SYdBz/+ZI8HjyiQHK7SJdg7jfJWm6yHeNVfTVwyklIYCMw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2769;7:oIiaF69sna3Hu38njGTablwOUuHm1U0pAJWF16Fb35bp92OpBJ6UOe/ECRQL9mNDU9fLYbqaGINCRodxN6o4eNtxMNKQzgBTk8bkzCgKsCBIGYvY33AzzP455aPWV4ITTUOhKEp68EpUU2E/c4dLVCLQ+eqAdba1zwt7YuAoYN2aa38egLrY95eoiD7yFj0O+MfTQ+UE+yw95Z6p1c1eQPUOXvDiq875I3ez0Q/z1EtWna+3FLza9dBVC8rRgFYs;20:VHU9N0i/uJdTjNJAuVAh2ZF5vJUiMFmR9KIpIjW91r4usD+ARH0IkEBPh3/4bc/xrPv/CKkmTnFYq76fIHO9qyXMZE0oWyZfYKz03v4YO4PYclrIkiRCutBNTWr6UlENf7zTcUaoLlc0aCIfE566idroOUGyaunKGK3TQKw7NLA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2018 16:19:57.6615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6866b55b-9d3f-4a1f-efe0-08d5eb37f9b1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2769
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Jul 2018 16:51:03 +0300
Jan Dakinevich <jan.dakinevich@virtuozzo.com> wrote:

> This table by default takes 32KiB which is 3rd memory order.
> Meanwhile, this memory is not aimed for DMA operation and could be
> safely allocated by vmalloc.
> 
> Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c
> b/drivers/infiniband/ulp/ipoib/ipoib_main.c index 26cde95..cb752df
> 100644 --- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> @@ -1526,7 +1526,7 @@ static int ipoib_neigh_hash_init(struct
> ipoib_dev_priv *priv) return -ENOMEM;
>  	set_bit(IPOIB_STOP_NEIGH_GC, &priv->flags);
>  	size = roundup_pow_of_two(arp_tbl.gc_thresh3);
> -	buckets = kcalloc(size, sizeof(*buckets), GFP_KERNEL);
> +	buckets = kvcalloc(size, sizeof(*buckets), GFP_KERNEL);
>  	if (!buckets) {
>  		kfree(htbl);
>  		return -ENOMEM;
> @@ -1554,7 +1554,7 @@ static void neigh_hash_free_rcu(struct rcu_head
> *head) struct ipoib_neigh __rcu **buckets = htbl->buckets;
>  	struct ipoib_neigh_table *ntbl = htbl->ntbl;
>  
> -	kfree(buckets);
> +	kvfree(buckets);
>  	kfree(htbl);
>  	complete(&ntbl->deleted);
>  }

ping

-- 
Best regards
Jan Dakinevich
