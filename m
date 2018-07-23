Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2A6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B38B20685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="uroEjZDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B38B20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388183AbeGWWUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:20:48 -0400
Received: from mail-eopbgr50082.outbound.protection.outlook.com ([40.107.5.82]:60295
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388088AbeGWWUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o//tIm9tPYm7xqFqZIVv7gZ1G/z8RCXBULPNDu3xDKo=;
 b=uroEjZDkq4iZEbuv68oGuW9bCpbU8so4cFOstB+ET2WIs6OWwGS5/qYGVMwRt87EbbCBG+ARtzFb4iAkznXpgSBH/FRIz56qtGqNXqPgxiT1ese7KQ5aTLzGSMwC0ot/PujccLDPa4B23TTuH4PTawJID597i8k6s0Y+fDe+xb4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=danielj@mellanox.com; 
Received: from [10.12.149.22] (208.176.44.194) by
 HE1PR0501MB2265.eurprd05.prod.outlook.com (2603:10a6:3:27::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Mon, 23 Jul 2018 21:17:36 +0000
Subject: Re: [PATCH v2] IB/mlx5: avoid excessive warning msgs when creating
 VFs on 2nd port
To:     Qing Huang <qing.huang@oracle.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca, dledford@redhat.com, leon@kernel.org,
        gerald.gibson@oracle.com, sharon.s.liu@oracle.com
References: <20180723211508.7078-1-qing.huang@oracle.com>
From:   Daniel Jurgens <danielj@mellanox.com>
Message-ID: <be7536a3-3548-3e89-fad4-71180511a5ce@mellanox.com>
Date:   Mon, 23 Jul 2018 16:17:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723211508.7078-1-qing.huang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [208.176.44.194]
X-ClientProxiedBy: DM3PR12CA0066.namprd12.prod.outlook.com
 (2603:10b6:0:56::34) To HE1PR0501MB2265.eurprd05.prod.outlook.com
 (2603:10a6:3:27::6)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebc7615a-b4b9-4bf9-2b9f-08d5f0e1b76f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0501MB2265;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0501MB2265;3:kwZOeU56hDJu5pL8EeUjy0s4fTHXfq0lnDExcSV846aou3qkeYkQi5ZkXf3orNPhjeCP6SHhZ7k3ABqJYa5V8exeMF6HDkVqdWjCyI+vD+ijNs1uDIKirDof1DYQNRJvQjEUZgcefQWhZ2VTN/r/j5k8B/kX2ECifY1ed81SNxcOeRjYBcMuLI903s/Iz8x5FuNjyWYhVnUJR1LIarDFcYyXwVrJZVMDdi96q9V3hruI2OFuyr8ZZ6686K4oim+V;25:XxOEGbSxsqsHNcVZgiyvMbPWkRVBA4a6FLjxUVwYnY907PBvJR+/Otu1tJ4ggUBUiQnAWmNMVEKXaP9Lrq0xgYOZO3DAY1QejiUdagh6rGTtDKT4ru8CFSIi7qA5R+Hzc2+2YMrJ6A8xTF+VBJvqftFU2cXaPdZjDmTTrDvtMGOUdnAqx4gOJlH+78+ih/B9Ar3FPD+sL5Hhf3K3ah/EOP2x0wBgbtfQ5vjKynPPhdUGK4vCWpZIhfHgIbFyRJXSuLs9H7Md7OWLOMN1jz0p9pHkTewWORRahzukmdVLT5Fr9KcG//0Cx0up2d7xHeLWZjinIGyhA3stxfg7eeS/zQ==;31:rD5NvaR/1E3p/YeN8WgyBHnNmWDfDS2ijSFXuoHmw/kuQc1sZDSUzBhlOElVUA6I4pWl8mID98LsmjYSaUXnO1yk9I+664ItYaBo6+Rst+TM/yKsXng0kPOQ5DRt5NIqVttYCwJFVUdtD6dwqzzRxtbx0zOBDLiUv+DrEfYYx0K4CVKp3Nvc1fLYQHp0O/vrKZxrTb/3CnY+k+tJo63+gjnd2PqxVhCW/CiPj+g8CXo=
X-MS-TrafficTypeDiagnostic: HE1PR0501MB2265:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0501MB2265;20:vEZtuQaRqi0E2+ld7kRgla2tyHHNCtYf58zoNN2TqPrxld0Wz6xPryB91vilEKKVIZ8qBTU6/ZlbieWFPyi2pETYuWNDk2UJt5qEdik3cq/QV02bYc1qJHfCbMeRPIfIZn36pf5iD2EyZKw8ZAaSJcsQmYWiA4ssuZKBPVKtZgIrdSvrlO7R3qlTdBk4MQrIuRaqBs7a3NPVBXWmMqeFQMOUg3o07p1OaA4ta2CZmjleB9ujSJWynjB+4T7Q1hAuwx9/M+G7LEApepcgC0veaIbHl1/Jkhvc8gI6r7FYff9+Pj3sgoXPHB0FruvqqgTIgtdGNkz51m2+WEAIaNi2A0WxKqiOxvxxhnksXNjDfprUaHrsVbMZGAC06bfs2yJSXL3/dLY6E0Jy+2HvOpsy5dNrJZVp4XCe4IBXf6Bpsm+RgiXm/77wqvaU5883qXKak/SuK11PPSk/DIv4kRNa2Z0jr/oLs68mwOOOHGuKR01HXI0jDaeeO4CZ+wFVk7Ue;4:xoH+7DcE1Pe5qGRkIuYPcwyuyJ5ct5IEU1BkeVZYXj5DDse4kf79glEmu+2tupT0P9p0aFezioQnhMXXNtmFYzNelWqfvtbl0D+RUDuOkzFZYcm6KiREcMVX0nD7Zpd7mln43xnxnrCTVgkjlXipLdqYbfDFN62hxleafMl3CpZP7l7wM0gnppVZLiYcoa/yH+AzuBOjwTYgrWnxy+ApDacy2z+sY3fZWO7XaI80HWLRZaQCq0zSqgm4Xq+gAX4QTqGXV46HKBEdeD2wzwP/9ViYHAprNWkEd3S9alYDMm9teFc8cu6fOdAhUHFxQkfa
X-Microsoft-Antispam-PRVS: <HE1PR0501MB2265A009A6B0B1369EEA39B0C4560@HE1PR0501MB2265.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(146099531331640);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR0501MB2265;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0501MB2265;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(366004)(136003)(346002)(396003)(376002)(199004)(189003)(77096007)(26005)(956004)(36756003)(2616005)(53546011)(52146003)(476003)(2486003)(23676004)(106356001)(105586002)(386003)(5660300001)(65956001)(66066001)(65806001)(50466002)(47776003)(486006)(81166006)(81156014)(76176011)(6246003)(97736004)(11346002)(446003)(52116002)(316002)(16576012)(58126008)(186003)(16526019)(8936002)(229853002)(6666003)(25786009)(3260700006)(6486002)(86362001)(230700001)(31696002)(53936002)(65826007)(31686004)(305945005)(64126003)(2906002)(8676002)(6116002)(68736007)(3846002)(7736002)(4326008)(478600001)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0501MB2265;H:[10.12.149.22];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA1MDFNQjIyNjU7MjM6TittR1l5SEJ6TE1adTBCRWQ5Mnl0eHZ6?=
 =?utf-8?B?azNtNFdpNHIza0J4RU5jUUxVSUsydTJNZ2FXMWN5REJYbDh5MG53YUxVK01G?=
 =?utf-8?B?dysxNDVJWUcwRi9nTVk4VmxJODJ5Z0JWL1k5S3RpL2ZKTEZLZGo0QzRwbUsv?=
 =?utf-8?B?STVXZkVFWEN0THRvTzBGWHRoaDhGY1JEQXB4OUNwN0lTeXhhVlFNSWNsaUl3?=
 =?utf-8?B?RzZOLzFpd3p2N2liaHFDTVhhZEdJaWhBdjE5MWY5ZjRWVzNtTUg3WWRydU5i?=
 =?utf-8?B?ajRmczZkYU52eXF2WjVWcEwwNTZqRGdQcFhjMDhmN2l3QjNPa0gyeTFxK1ZQ?=
 =?utf-8?B?Ym4vN1hLem0rbCttR1pLMkxxVDV3eVNWQTFQWTRzUklEbFlWWjVpSlhmNU02?=
 =?utf-8?B?aVc4OHl1M3dkV2M0NWN5WWQvSzlnQ0kxK0UwRUE2dHdPWU1RZFNKUnZpb09T?=
 =?utf-8?B?ZEptWnhpdWh3YlVPUEYzcitSQm9DVlNsQ253MElJbTZHcEt2YVIwbEs5aExw?=
 =?utf-8?B?MlpZTm12UmxjQ0I4c01MZ05YTkdJemhPUURSdUI0MDd2MEREaTZsNUtKLzFB?=
 =?utf-8?B?ZjlyOXU5c0RyY0FHYk96bGx5d0hFWDRja1hFM1prQWtRTEhwN3phMmFBVHhK?=
 =?utf-8?B?d2RMcXNySDE4OEQ3emU1dGhFL1RjSVVuOXo0Z0FMdEdhdTIzZDE1ZTZFbTE1?=
 =?utf-8?B?KzhEVG14YjJmWDYxZHhHdWhYajJxSzlxcmYxUXlHV0dGNnZwVjN2NlYwWk1U?=
 =?utf-8?B?MXN5a28vdVRCK3pIaktPZ1E5MlpmTmNHVm1ybjRabTk5TjJCbTNmQnZtZ0Nq?=
 =?utf-8?B?WHltM0VNWTBXc2c1azg5REhISERXczZPVmJtSy9WeWxlM1EzNHVXMXhMYWQz?=
 =?utf-8?B?VER6dzc1MThDTTY5Z1NXbnFmR2FITHZsSjJBK2lhdFRvaFd1c3Q1TjBlMEoz?=
 =?utf-8?B?V0FLOFdUT0JvYXllcnlxVnhINlVUR1doMFREVDQzdUEvVmwyRlMvME5HQ05H?=
 =?utf-8?B?TnVyU3FjYkxrWUt4WmlqZjNoREZ2L2JFRytlOXVITmFlS1lHVmdhb0ZvYXRN?=
 =?utf-8?B?bmIxTnRVd0dJOVVIUW9YWXdiVnFHaytyT2VaaTNaeDdGWVMrRW9PWnVGbnF5?=
 =?utf-8?B?dGZia2prSHF4WDlxTk1na25idEJGaHJnZjFkaXdhcklhenBCSVFxUWhlWHRi?=
 =?utf-8?B?bWRUMVRWeVd1SGswTmkzQ1N0NTJIT0ZVbmNLWmVXckwxSzRzVzFkelo4UE1I?=
 =?utf-8?B?M3BpSmhCRlJVd2xMYWROZGRNbVhWcDl2UkZ5TjcwaVpDckVua0hMR1FpREp0?=
 =?utf-8?B?aUYyZWdybDhJL2JQc2JFZE1acC8xSlE0S09FMmlYZ1ZpK0JVeGxRQzBGbnU5?=
 =?utf-8?B?eU02ekV4WWJkREQxeU1OM1l1MVlPdHJsbjE0OFEyMy9BWEZXTUxqakp0U0px?=
 =?utf-8?B?bHlKbUxqNUorVkpwcWVuRUt5V29HTXd0UmwrRnVVN3E5US9tZVh1clh2RHlE?=
 =?utf-8?B?RUdQdmNmWmdvS0VaTDB3ZlBaVFhubk12QmEvalV6eW92cEdMbitQejBtb0FB?=
 =?utf-8?B?MkRpRHBENWZ0aEhwYUxsUFova2RBQnJxWFFxSVdvZ01OVFc5OTdyRU5GanpQ?=
 =?utf-8?B?ZDhjeVh5bzJlTnQvOUlEcmE3T3R4UUlDQ05lZWxod1dSazJvell5VDlsN1hs?=
 =?utf-8?B?Tld4QVBvVEd2bUdVZllNU3A5Zzl1QzJNOHBtNFVqRGhkYkxGUTNTNFlXRXN0?=
 =?utf-8?B?c1RaVmJlMStaOE1vWll3cm1mMU5jSkNOOGRZYnljOHduSHh3TkZzTVB1UDcy?=
 =?utf-8?B?V3Y4ckhyKzFLMlpRaXFmN1krTzdNWGxFVlYrZFFxT05PbTVQeW5HQ3NHVDJ6?=
 =?utf-8?B?SEhKK1dNOHNEemtDVzBEamc1Ti9WT1hwYXRYTUJrbzE1RlExNHFYWXJPK3BH?=
 =?utf-8?B?WTJPMVFLdWRwcEE9PQ==?=
X-Microsoft-Antispam-Message-Info: 0/dWV4K5eLKvKBEF3b+nZbcD6TR1PVJqiAo9dyIp3GDUgPAUnmpZnRQE66oyGiiwgrPIf+KeOxSsR7aIApGGenMjFIr7sY4Rd+tievkji+yhXGlpHB89ZElpBj4NJ6bDOpq266VHFwrbxO5Fe5R++Wpx2zkvGrq/P3VPbYoSwcZXxvsGJQJW/pTh0fKjpJGkWZ/QNvddzmnubxOp6IJkDPFlwphR/mSxpdVrM6JiTO/URoN/fgxVVSuHFIQ/xLlSBF7Q634c5LjqqCVm541jP+kyma1tQEC5g2d+MKAdqNV7saGM7m+nEKuAk3CMyaJz5bImJnK03HCIhVqVu5yB3V1MPzpVqcMpLCM8vGH7yNc=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0501MB2265;6:kdoKBONcuQz1jUnAqdfYUZfvhY/NFGk924Xmd4jIV62VKvaMCWjPZ0ll277Tr3lR4yu05MzHxbEGOC+Nqbvxh/BZ+0qWS9luArOYPIRjBaIMPvv/qOhcZwyfE7ZZ12Arx5k7q3tLAj8vnVyQHCJawLJ5Ixd4XZ6W1Nhkgcmf0pbOPXWym023sE05RxHF5yj849gwY4V8H8zJ6Yri5eu/pN6/bV81PNiFGBRaqeHk44B8z/bmoDHSt/aJG336mdoUStH9d+/4ZIsKZwO8mUmZqZQt8s+ag4shiOk3W2V3mKqxZOhgU8CKJCHI5liBVFmCdYU5epN+rgXWqhaA1L7GPOTuWo74ZeJVjFyxsu1Elqz8c6hpI2VfAWkOI6KaAsJDMis+LgtzRmkLvwTSf3avECUdS+mOTGxogdxZniTdXVsZhX0R5wkpac212spJLwpLKj0W2Mq6BIjYuUoqBTPjyg==;5:zw7ts4/TfOINvG2wj+qjY+geFzqztmsxv72+FX2LurIcdYHdTyjGWHECcp+xlavTcOg9hElZoRLB7f/tXXU57vbbC6yGBpZnGo5WSwpi6QsWF25Gqlv3ckV0xm7U12iatr4lMxaRGV3mU+LQL6GizHcGD//cY5FvO6cSqhAg5D8=;7:Aqfr6k3FLRJ4TJM+LzJqjOeanaEWZU0KKeifinxXtLqAp7NStq9n/9LkqAfUPjgm+3TycQq9nS/9jG72pDtjcMgAtxhwM0wH4rDnxkaWBlM8hlOZHNeKFBOvdvxpV0DMUlWoYRk5U498x1gvJ9MwejeQG6NVD3FaOXJmOP6V2byNwO+OmNkK4Cvh5V9wMnvwge6BJ1DQo3L9z48LPUwMj0Mny2sWiGhK8ks9/Z3ZScdPa5Xk+TEy9Pwm1EPLeTs4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 21:17:36.0492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc7615a-b4b9-4bf9-2b9f-08d5f0e1b76f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0501MB2265
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/23/2018 4:15 PM, Qing Huang wrote:
> When a CX5 device is configured in dual-port RoCE mode, after creating
> many VFs against port 1, creating the same number of VFs against port 2
> will flood kernel/syslog with something like
> "mlx5_*:mlx5_ib_bind_slave_port:4266:(pid 5269): port 2 already
> affiliated."
>
> So basically, when traversing mlx5_ib_dev_list, mlx5_ib_add_slave_port()
> repeatedly attempts to bind the new mpi structure to every device
> on the list until it finds an unbound device.
>
> Change the log level from warn to dbg to avoid log flooding as the warning
> should be harmless.
>
> Signed-off-by: Qing Huang <qing.huang@oracle.com>
> ---
>   v1 -> v2: change the log level instead
>
>  drivers/infiniband/hw/mlx5/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index b3ba9a2..f57b8f7 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -5127,8 +5127,8 @@ static bool mlx5_ib_bind_slave_port(struct mlx5_ib_dev *ibdev,
>  
>  	spin_lock(&ibdev->port[port_num].mp.mpi_lock);
>  	if (ibdev->port[port_num].mp.mpi) {
> -		mlx5_ib_warn(ibdev, "port %d already affiliated.\n",
> -			     port_num + 1);
> +		mlx5_ib_dbg(ibdev, "port %d already affiliated.\n",
> +			    port_num + 1);
>  		spin_unlock(&ibdev->port[port_num].mp.mpi_lock);
>  		return false;
>  	}
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
