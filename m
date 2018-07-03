Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DF3C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0209D24494
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ORyjSMRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0209D24494
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933857AbeGCKD2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:03:28 -0400
Received: from mail-sn1nam02on0082.outbound.protection.outlook.com ([104.47.36.82]:56148
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933565AbeGCKDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4wwCI/iTuSDTEo0aqXg8jkCrtX1dw4O3Qemzjs2l4o=;
 b=ORyjSMRjpPpH/7hb9d6zHaWcRVNNA4So2EQzBp3jiQMl/dMV46x7NYmfklTPg9WL7uEB18MU8Y0duJXzEcw1RAlRDOqIUZzBM3aiN/65FQ+8IIZWMLqh5w1xFFgMlCNP8SesFDLDb9yqOJQGe7aJEcplYAE9PAQ1QDTDkZg6Des=
Received: from BYAPR07CA0045.namprd07.prod.outlook.com (2603:10b6:a03:60::22)
 by SN6PR07MB4717.namprd07.prod.outlook.com (2603:10b6:805:3b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.25; Tue, 3 Jul
 2018 10:03:17 +0000
Received: from CO1NAM05FT030.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::200) by BYAPR07CA0045.outlook.office365.com
 (2603:10b6:a03:60::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.930.18 via Frontend
 Transport; Tue, 3 Jul 2018 10:03:16 +0000
Authentication-Results: spf=softfail (sender IP is 199.43.4.28)
 smtp.mailfrom=cadence.com; linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 CO1NAM05FT030.mail.protection.outlook.com (10.152.96.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.930.2 via Frontend Transport; Tue, 3 Jul 2018 10:03:15 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w63A3Br2018940
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 06:03:13 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 3 Jul 2018 12:03:27 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 12:03:27 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w63A3BIg029148;
        Tue, 3 Jul 2018 11:03:11 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w63A3A3k029141;
        Tue, 3 Jul 2018 11:03:10 +0100
From:   Damian Kos <dkos@cadence.com>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Damian Kos <dkos@cadence.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <ltyrala@cadence.com>, <pgaj@cadence.com>, <stelford@cadence.com>,
        "Quentin Schulz" <quentin.schulz@free-electrons.com>
Subject: [PATCH 03/12] drm/dp: add helpers for drm_dp_set_adjust_request_pre_emphasis and drm_dp_set_adjust_request_voltage
Date:   Tue, 3 Jul 2018 11:02:14 +0100
Message-ID: <1530612152-27555-4-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1530612152-27555-1-git-send-email-dkos@cadence.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(39860400002)(346002)(2980300002)(3190300001)(199004)(36092001)(189003)(42186006)(476003)(105596002)(316002)(106466001)(305945005)(2906002)(26826003)(446003)(26005)(11346002)(2616005)(426003)(336012)(126002)(54906003)(486006)(16586007)(110136005)(5660300001)(50466002)(7416002)(69596002)(36756003)(4326008)(356003)(478600001)(87636003)(48376002)(50226002)(81156014)(8676002)(81166006)(8936002)(97736004)(76176011)(53936002)(47776003)(51416003)(186003)(86362001)(14444005)(2201001)(921003)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4717;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT030;1:QP9ueWEQYatk+6zNn/43K7udpLn1Naay7SUwTIO1yZrI1POLx14B1IJt0syzTJvAiMWzD4KXcxQiR9ZCWNlYP3WP26rq3ch7IfIPQ9i82lwDk/NV+Ql7Yx3Jt29CoW51
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99189246-8203-496a-b747-08d5e0cc320a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN6PR07MB4717;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4717;3:VuSYRJqGExqyKL/16NJ2UIx287g0BpCZQMwOD+sCOMfmTFDBUitoe2TVlAqzJ8w3raYLInwQFJyra0b+9KB2ZzvirFmq13piGEAQgh0nT1UjW9atnhHekdVyiXpn0XnhCB14Y6TUexBCgko2rZQTmuSfCcsoiUDsl3WGcySBQrDO9bKifESxDpjZu/r2oQn/w9VNXlPJHEN+awEVIWJjxXRhcxnXx93HUdsW0jdCQofSYKxkFulqQ6l9gZQiltd2IK4DVfPG4o6G8zhzZ+U9m0p/zdaeGoZG1qxrvWxo0oWrCl/0PfmFgPrQylCax1RfqQ1hrLw7X5uy3PgJLecGEQ==;25:EQuyyrPDOwW8DA1s25mmM0BWxOqSmRNO7gMNQIhIkR4zmwBwzbLzxvbPHmbUAbuuySy9AUn9WvlWpBNRqt0M6k7taqRYDRWX2zdj+m09aLIXX1AgSoGPkMDTwHpKB2lkVoWjIgUGU+AM6I5yFaARTAX/jGNmSb/9VI/HyCKReTraXI60/oLOgHSxQvp1fUC/nQcz2Ka/BWG5hp8RvMxCkW6/DBSVcxuiB2FpjrBcupC6XUV9xP00pOe476cYg9A6JGqsKXI24lF6fjb7dzFBEnF/w9s+0kfbK0++QRJr81Lay+f+NZ6nMVcWk8MxsahouXLE5GMkZTMM0s3LWrA8Yw==;31:K3t3JDdqATuGtU/zg/6d3m59Hv3z56dCXA7Xvb3CdbXhwVR+I61PdZrJPyxyhVsO/C2k1sWMOGFuc5yQHMHHDh7wnlheai+18nB/jXqkHzjsAlXnRjN24PpzpzLukTCN1P7qnnpKg8CygVVV/85yy90T40g69xxRNK0aZBpFgDS9UzFqpBArNSSJjXhL2lB2fOXTG/nGsH+2yJg13emwMwBjrt0mQfZHnOfpDPtk7sc=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4717:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4717;20:WOu4laj2TXTGT/gmN3irxNQjb3J7PDz62DsTpCF7/S3WuU0tiCS+Yn7co0jrmCo/Mk3JYL359x7uq4m3dhukE932nywCH3bE4n8vOQSMccUkmyINlBKD4ZHoSnnBLxITv8QMNd4jYyENm9IIFqLzTcjONMsZrvBR6SOy31G123yBzaiQsFlcdAVIEf+KQgClasIFw2rz4NJwLHHpmgN+/YXMvWjjUBAUyFkenFmg3uj87j73ULpecmi98lf+nSOguHbauO5lbauKozP+HrrsMTgt9hESYay1Oxyya4XmD4uzG9esRCBhcW7LrYeG3hIZgfbfqlPxYm/CzzLALlDV3iEchdjjulybL2dZZY4sbVRMlHsnAfNjZSA7lloFF7ecSU+1HIoacJKnMwGR3bhMbLUxXNrQ9PjatM0MUFYFQqglDpcQz1BYSvvmTqbvtzvFTlwfg1aJlbycTdR4Y437+EQdCsVE73pGkSmmjnC+jhhUQfBgrASJBJBzBhlgwrH9;4:tG3hpw+0/BAxvBMCb0N97jg90FT7r/Yv8AyMrquapaB9v20J0GnN2K9C/KY8K0x+o5lX+6pjvKFQ9Vq+FNjZugmwX79/xBxrCJt5OpeC05fYyAlG+rCcthXmgZ7Gcpm0nb/qHf3riLdSobG6xg1341M0HNdKdjBsH91BNCO1ESks9abWQeYswShMmVVongdgqQy1o3mk0Bv84uDJFvsLS/VeuNb99aXPOb7D7JQz9OZU5wW+Pgs7fQ+ACVCczx58ffjHuxK8jaJHGOBRaI99GoQfFo2X3jhnxAe4+op71Cb3ZMKLkMKxOk//5kk8Zp4xrkVtTqdyTx6iUzwiV6I30VCbOH8duc8x63Smq38JY5s=
X-Microsoft-Antispam-PRVS: <SN6PR07MB4717D25B5F805F29BD2EBDA6CD420@SN6PR07MB4717.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(10201501046)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN6PR07MB4717;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4717;
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4717;23:riC6+ClP9qMvuABCwM5EKVgXwkspJlgCn3ZtVBTKR?=
 =?us-ascii?Q?6uE39Ft484wYwdTg6rapJlRIZtaH2nsFcYrYdcPKs0KnsJwOWVLpnaXZTFVi?=
 =?us-ascii?Q?9qSH5kbx9pjaGSSgR5Iuj6aUhq+BQ6DsGbkenPLD7sH7gfiUgTEF7QYS5yHH?=
 =?us-ascii?Q?zYzU9vKsGmU84/A8CPqrkAWFy6/nT/n4xSVX7ktl8SvnO5962MZ50d8JM7Yq?=
 =?us-ascii?Q?8VL+j7RAoeNHbTG0Q0Wksd/PJDVsbnYJYpJtsblsLJ+Npt3UsEdpaA1H4f6O?=
 =?us-ascii?Q?ZfLivkjFraLKTiPcOKaozzdi2itTEh0cG8jycNVEAUxNOY+cyrZjP091Nnix?=
 =?us-ascii?Q?i0RkSD16C+Qr8RzsNTfzaJc1+xR/6bWpxps5M7JURYgLbCTdczwcN+Shi8hO?=
 =?us-ascii?Q?Zt8Xmw0He6OvItTM/prbn3Zaw1AlMmvVCYo+2TYI4GSfz3B2Z0p9WheRxX4W?=
 =?us-ascii?Q?iKTYP/QOhnPLQ2iU85R7tNi1URWmD9Q+ihC2wWbAGSlhyWjQgGxK4Co3qga/?=
 =?us-ascii?Q?yGPRYwMlF8DnXs4dvkwxHdG4smdb8QgzD/5zac36KK6p8ISK/WRPwtgQAnUV?=
 =?us-ascii?Q?HgktQwq8k6AlziQInWD3K9CuTmYpc7jzgawcseW17kgDQ7QKq1h+B2ON6BSN?=
 =?us-ascii?Q?2LMPquvKd2Ec3c6U+Ep2Gv0Sf/nxyOvnUks3L9VqCCxPl03WthCv8RoGlA55?=
 =?us-ascii?Q?e9fhUCxq+e7WsYW6t0OwZHWI8w6GkxnY9tRxu4OLRGDRRcRctHVRrm4PMiTW?=
 =?us-ascii?Q?mDyg22Hj5Nb2va+ZQZoQxCDFz2PaxI4LbIxHiRxG/e9S4wAUv+0SUPs00o4I?=
 =?us-ascii?Q?le+9j7iq0sEXpEDM0Bh53frwciM7wYxMQUqhOyG2EjrXuXasUkQH0Qxy4Xwt?=
 =?us-ascii?Q?rIkcXr2sHnu2Jw1q4R0PeFt4v9INseSZa1OtWrc/Y3il8f+Krx1dkO1Py6kU?=
 =?us-ascii?Q?faf3oMLYioqGWc7xtorAK+uDKCxRENYl0pVP10xTLySoyDIgp08VAnb6YoDz?=
 =?us-ascii?Q?tb42fa3TCPvpUObXWXnqmDqGhUUV+vSAbMGuknjhj+QRZKE8jTEvfZakVUnD?=
 =?us-ascii?Q?pyffiYWwe/nyAO554+oK7hCSDmxhbDml+o2BAVoxrVWTV1yjcvLjnOu3sxgT?=
 =?us-ascii?Q?0du24goxfFjsmWClAMd2hh4IJ7yiUs1du48xnHUla3NFZofv/uPVPKzkY/gU?=
 =?us-ascii?Q?9pliVL50khZCMKI6kk7x/FyudzilT6gXV7nkp1CQXVk2KMO4fcitMgA+Ek9f?=
 =?us-ascii?Q?mRn12W0BQYNoG/zEnlDP8KY97yVI+uUr/fpJp2G?=
X-Microsoft-Antispam-Message-Info: cZP/BA6aSUM10fLr5xUYJgIXP5buECYlKbVm49z8f9sploZK7qGi1MpwXDULR6YTnXhmbyorJsN9B/L1JPYT1GWV8LO2YPrHh/jjbYXfHSlAYLJj7Qd96wmkx9d/2+vjO+qkYzLAlRt+vbbVMa84Gpei+lQPv9PvgzLuUq6SLEeLus8wxNauF2RoTpd8DbcMHx5Dzy5p0Oig7kxYtwjiXKtREf6EOjUhgF/2fpaKdOJKNTghlGaqNbGqdqGgOFZnQ9ujOpgnbHAhVtqUwxravd1l4nY/ChNCX3ZxNrhu+G3GtvtRTrIagxvhPEXRdfca9HYYHu4X/G+/LHnxJIFnoqZiXHdH/UChDBgz5tLRr5Tb6w4XiNrT1d2llltV2EoQv15JlzKHBvbipufufHV9Zg==
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4717;6:pdtmkDVtnXqGVN9PdW+Vr8bPHgHoiJeTtBleqpVzZP9yDFI/YynpeqZoKRdPvElYhUTv7KGoYcOraKfgHu+PApKgEuz70NXsJsIvWlTGZa8z8hpz4ZDYKCfXCe/7WsW73IYN4w6nSZPNwWKq2heueOt/zfebvu4YYouGVcAg+2VuLYBGGC9ABFDyskagisUxmp1Oi1Jt0ew0Hw807dD58koqP3sHQfyH+syaxYeG38/ycb4423wnGcflpGOywpqKeml0ukd253vOXQ0H3FiVvw9Vv25o/eNfBDz3O2Yd/6/J9WqrD8pD9dNlcyPvd4P3+Vic4Ltgs4gftVWpePzt7JkqNUCpFaCFgdDhw1+HZNMXKj5NSaFoEHJE6dLsa5Cjx3ikYi7j5r2/JhDt05D5bCsVGRkHUjgfl3/bNk3+bMv1L187df3FmlfNcz5upTLAzryWD4cK84CeMYDg+p3W8g==;5:rZnWgG0/ZpGTfjHWInlZhWEx2Hzq8MP9mVV928ZbKFw901kagFMAHrUH5U8K940++EL3HiSqmQVXFkegRhvTVjKn1fKyoDAa3FmOT0JoaH6QW49cBrla0T2VO/7W22p7uynqkvlABmP4cIfkx1QVrfL6oVeqvkSAHNhy5y6nKlk=;24:dep16G+K54msc0HsRQhgkxw81xt0E422pITrLFI9O3uSw/ZV46TsTl2PzdZHeeZi3T0SEHo4OZGl6ravrCFUWA2uNEzujjAZmkpuF9+NLt0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4717;7:hy4BlkysM+PxMR3ENqhlaRF50C36v8VAca+pJ7Y79vJJxm5CwMvSsKQcqWeuhLf0H2nzPFOQ0AeKXu388MFPP41dQzGGzBFBXz8uB/qaOXQj76DCUvTKiaMAH/br7X2Y1RvF90745XVJ/omcnraQkcQH/GLOX39P3XDcPblQuNecMYFdxsS9+7pleR2HMfJZqzNdmj3JLT4kxKAPLLI+oYopzTJCeRkZuwJyPFMZDIVLVg1upBxWvhXRu80FbM1S;20:AKGE3ceuUc9Nfhcjw3QLI4n35vIARCb1zlrUWnjH3ykxMxUEGBgz7KuCSBwF1Ce0d7ay6s/9L5nbNYfgXKKZJZCVBpVckz+AQzlg1NchT3OyV7rWeZfel4yTKzmjlyCdJfb96aNvBwWeRKBjkuY7wWbK1iCVqpiYIEILIkoGlqVu+w35HNFLStt0mtKCmxt/OZxQYeXyOrI2hnQJX9oSPRKOdghhGwv3cu7pngSwiszwVcOOhC/r9FqSfBQAuTPA
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 10:03:15.4212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99189246-8203-496a-b747-08d5e0cc320a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4717
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

We already have functions to get the adjust request voltage and
pre-emphasis for a lane so it makes also sense to be able to set them so
that we can then easily update them via a DPCD write.

Add helpers for drm_dp_set_adjust_request_pre_emphasis and
drm_dp_set_adjust_request_voltage that respectively set the
pre-emphasis and voltage of a lane in the link status array.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/drm_dp_helper.c |   28 ++++++++++++++++++++++++++++
 include/drm/drm_dp_helper.h     |    4 ++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 3bc2e98..ca2f469 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -120,6 +120,34 @@ u8 drm_dp_get_adjust_request_pre_emphasis(const u8 link_status[DP_LINK_STATUS_SI
 }
 EXPORT_SYMBOL(drm_dp_get_adjust_request_pre_emphasis);
 
+void drm_dp_set_adjust_request_voltage(u8 link_status[DP_LINK_STATUS_SIZE],
+				       int lane, u8 volt)
+{
+	int i = DP_ADJUST_REQUEST_LANE0_1 + (lane >> 1);
+	int s = ((lane & 1) ?
+		 DP_ADJUST_VOLTAGE_SWING_LANE1_SHIFT :
+		 DP_ADJUST_VOLTAGE_SWING_LANE0_SHIFT);
+	int idx = i - DP_LANE0_1_STATUS;
+
+	link_status[idx] &= ~(DP_ADJUST_VOLTAGE_SWING_LANE0_MASK << s);
+	link_status[idx] |= volt << s;
+}
+EXPORT_SYMBOL(drm_dp_set_adjust_request_voltage);
+
+void drm_dp_set_adjust_request_pre_emphasis(u8 link_status[DP_LINK_STATUS_SIZE],
+					    int lane, u8 pre_emphasis)
+{
+	int i = DP_ADJUST_REQUEST_LANE0_1 + (lane >> 1);
+	int s = ((lane & 1) ?
+		 DP_ADJUST_PRE_EMPHASIS_LANE1_SHIFT :
+		 DP_ADJUST_PRE_EMPHASIS_LANE0_SHIFT);
+	int idx = i - DP_LANE0_1_STATUS;
+
+	link_status[idx] &= ~(DP_ADJUST_PRE_EMPHASIS_LANE0_MASK << s);
+	link_status[idx] |= pre_emphasis << s;
+}
+EXPORT_SYMBOL(drm_dp_set_adjust_request_pre_emphasis);
+
 void drm_dp_link_train_clock_recovery_delay(const u8 dpcd[DP_RECEIVER_CAP_SIZE]) {
 	if (dpcd[DP_TRAINING_AUX_RD_INTERVAL] == 0)
 		udelay(100);
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index a488af0..6e64b2a 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -946,6 +946,10 @@ u8 drm_dp_get_adjust_request_voltage(const u8 link_status[DP_LINK_STATUS_SIZE],
 				     int lane);
 u8 drm_dp_get_adjust_request_pre_emphasis(const u8 link_status[DP_LINK_STATUS_SIZE],
 					  int lane);
+void drm_dp_set_adjust_request_voltage(u8 link_status[DP_LINK_STATUS_SIZE],
+				       int lane, u8 volt);
+void drm_dp_set_adjust_request_pre_emphasis(u8 link_status[DP_LINK_STATUS_SIZE],
+					    int lane, u8 pre_emphasis);
 
 #define DP_BRANCH_OUI_HEADER_SIZE	0xc
 #define DP_RECEIVER_CAP_SIZE		0xf
-- 
1.7.1

