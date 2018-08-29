Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7F2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E49F2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="L6eeRFmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E49F2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbeH2M0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:26:37 -0400
Received: from mail-eopbgr50093.outbound.protection.outlook.com ([40.107.5.93]:45236
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727133AbeH2M0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzlbUDz5e5Pqw++jaqxydCBEJPTP4Ub3Zj09vqrcAHc=;
 b=L6eeRFmoepK5mNx1ocfODVGt35IKHab0kWnFS5KFk528/AyHJ1fSVUepUep3M0j0nbSySS454Vl7BT7YB1xSn06CUpqHC9LptbRzwBcO/Rq87tbgptXTS1VYa30xabbPZ/HipPQ2p7XhJrrkxwRKdf+HHnmz14bzTGxCsd3Zm4w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 HE1PR0801MB2026.eurprd08.prod.outlook.com (2603:10a6:3:50::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Wed, 29 Aug 2018 08:30:43 +0000
Subject: Re: [PATCH net-next 0/5] rtnetlink: add IFA_IF_NETNSID for
 RTM_GETADDR
To:     Christian Brauner <christian@brauner.io>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        lucien.xin@gmail.com, jakub.kicinski@netronome.com,
        jbenc@redhat.com, nicolas.dichtel@6wind.com,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <20180828231859.29758-1-christian@brauner.io>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <adc2fae5-e22b-3a74-d531-01570e7970ee@virtuozzo.com>
Date:   Wed, 29 Aug 2018 11:30:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828231859.29758-1-christian@brauner.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM4PR07CA0004.eurprd07.prod.outlook.com
 (2603:10a6:205:1::17) To HE1PR0801MB2026.eurprd08.prod.outlook.com
 (2603:10a6:3:50::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 953ab576-9f0a-492c-2c08-08d60d89b6f3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2026;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;3:Nm3dcRpmuBnGC98c9w2k58zORnWbFYHF7COdwafj9FkpmA9zFEiJfWXbrbTI0skpRjbpc3M0UFNq5g5mPvPs4bjrsRZZC5LwRI7tSMIueMMV4oMAUCjVVvy8vK3xT6lwmeno6/ESd0Q7be1BUJRUV/iqpB4H5JjH6nrdbdsQ0cs0DieJgxUTBrbc73Tv/ZXeaBMbsvoqz1ajzYmc8Dkc2d4NRvxwDlBrWPRI0C5khf8vXtEkSAIRgN3D7BNYA84a;25:qIzYD8yasJ61DWBmoQ3rUeq72ZyWe5DyoxP6fv+GmGVPZZxY7IUt4KdQeDzU2j1qYGmIAgA1bl/1e8cuFPLhqClAfOst2SdmovHUINGAkAzBDycg7766DL+NQmGd4wSQJs9Jf2dHaG/HYEX9XhQzL76DvwZqGKlwvLgKYVU5REvX0EoP76+VXbEzTRIl/KHVkZki6lzSR9EamuA48YZ6wTLVLqmegbq708KVBx4AnJops07E403De+Tzd/uygYgYQSrqXEsZADmz9k8E+G3vASD2LY0kH73jlNu1bR4Of4tA+PgIhN8qbjRn6q/HXKIQXd4tVM3AaBYwitz01w9jvg==;31:zb2ODxedwpDljl/HZGbKIe5qfqJk/WooXFWJ2nECT0/dAcP86enfUPKo5ntSfpRCkHvVbOmBv1Fq5f+d5a4tkwQ1bEaPLz1PU4OBJltcCm3pIXmxLBG+slvL+IwZ/nj/+XjWPCZq4iOzGlZenktfWstFKtXtoE+6uvVvAMVl1CiKwqz05A46hpXgerGqMdsgNXS9boUU2KMxFDZpNLVL8R8sCkOLSi7zuOHc3hQiQeM=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2026:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:8EgqQxVm+L+aQsVO2DQH2MXoaJD2Vjjl/na/cgBvGjbuXDeI7E7f6SihJ9kcQpTCUAJRDwc8OK1PSUzf6s4tw+jasQXYVXVz5GB/q01Ocr8/zbTNDINoEas/Roh60XVnHeOmNX4iy76137T3HOW10knqusQKOcxwcpOX1w3QsBX2U9I5u23q1lIP+QlChvaCgOuyj7r5x/slifRoOk7zLWEHfIx41+rgiA9pHw7d3FNU/DpbHk0pqRowx+5l6HjBrmd9qRKGoLYZ6fICbiM6BKtuY2P6do57Pqou1B/sMu8maQB/O5CBCNdjd0glkTCDldwkfjaIftA1J7v1FbHlNai4TAOiyTx2Y5jaVGjRM41uvNdTxOnukf0lArWAD0zL3e6GA8Ury1EVtKjJM3DlQRn4i22agA9A85oEBEKAlWwuAdPspmr4CqUi8Mt8D3RF8vR9SiYgwbbPiJzcMPukktoHb7ly7KFJ0S7Z3IyaaF3566BpoHx2fXsI5piEi691;4:Y4E61e/fU2ydep07cM4jsy6sNS1HbAl3ZRJxlph+kzDCJFJhYK+B7y0ZaEhoXFqcbk8V533d1At34Vm+/dkaW1CN1KZlcjXcAs5MvRzRzRrWxaFgQXdMW30rDd0KL1yl6Xs0Okq8QykTlA5HTKhpJ/fEbsDuRN23IS7h2+yHISNJz4CdlxCyS65wnZJHqACLkVKGYkvYGc7or81itxUu/Kznt0T2s3sjDX9ZlE1rar16I+QrsN4F47GAJoRrfwld96nc66tm1tYrFw54jOF0tDIeEYUcc7LsYYOlniiDfYg0vSKEFX1lTW7p3ckQeFqo
X-Microsoft-Antispam-PRVS: <HE1PR0801MB20264B788A03D9E4EDC44C1FCD090@HE1PR0801MB2026.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:HE1PR0801MB2026;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2026;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(366004)(396003)(376002)(39840400004)(346002)(189003)(199004)(4326008)(31686004)(305945005)(23676004)(76176011)(14444005)(16576012)(52116002)(52146003)(2486003)(7736002)(58126008)(316002)(65956001)(66066001)(25786009)(5660300001)(3846002)(2906002)(6116002)(47776003)(65806001)(6486002)(6246003)(186003)(386003)(68736007)(97736004)(6666003)(11346002)(53936002)(7416002)(8936002)(229853002)(86362001)(476003)(478600001)(81156014)(8676002)(65826007)(16526019)(230700001)(39060400002)(77096007)(53546011)(26005)(64126003)(31696002)(81166006)(105586002)(50466002)(106356001)(486006)(2616005)(956004)(36756003)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2026;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjY7MjM6S3BzbWpwbEw2REZ5WXorVzVEQk5SaUd4?=
 =?utf-8?B?b1BiYlFNTmpvWGxwZ1Y5eUduOGRTRUJnbTFqRHhWc0lPd3ZkcEFOZnFrbE5r?=
 =?utf-8?B?S2s5MnpjUlVjWm1QMmovcFlJYWlydlpqNmdrMEZud0NDL1lRZWRDZzdIWDNa?=
 =?utf-8?B?MCtkZm1Vb3lReHF6NVdHVVRaSHR0eGFqMzFJZmZXTnZIWDZIRkRCdWRBRGlR?=
 =?utf-8?B?ZjdROHpPT0lFRmd4ZE5KU3owaFRVY3kzbi9HVkFjNEUrM3ZRUG1DREtTbStl?=
 =?utf-8?B?Y3FjTzdKeS82OVRVZW9zVmE5L2UwMTJiOVNXUjJRbEJTR3dad05oS1pwRG5o?=
 =?utf-8?B?WVgzYkg3em5hNkFLUWE5NHcrVjFFSUpUL0JtVnFjcnkzdWtPWHhIaVVNN2N0?=
 =?utf-8?B?MHhNZW5zRGxYejRuSVpkdXdmcEMybVhpc1Bpb2RBYTFtS3BZMVI5RGdMMDdm?=
 =?utf-8?B?d3FkUmNRT1dNa21FeEMvS1o0MzhzVTRqbm8rMENySUtTSWM0Z1c5SmE3Z2tl?=
 =?utf-8?B?TVUvSWd1MEJyc094N21FUmZCQ2dtUHZsQjBUUFZUOVZnV0dnN2VBSmlxems5?=
 =?utf-8?B?bHkyNmJBK2lRdjdKenkrbUZyUW54aTZndDNvWG5WY3B1M25aaGxJdmRmUDh2?=
 =?utf-8?B?UUhtaVk5UDZtR01qUWFRN2prMkRmTHMyYzdMOVg4VC9nN0FDY2dPT1k4NkFk?=
 =?utf-8?B?ekIvN0grbnU1aGVYQkJkbCtUZmJHU3FlWHk5ekVST211T3lpTjk1cmJLdEVF?=
 =?utf-8?B?SWYreEE3VWFBZE9vaHRkYmdjUmxuL3owMnp3N0c5ZHJmNVUzMnR3MmFzK3ZE?=
 =?utf-8?B?VllhWXYwZ3FwR05jd0VDYjdjQWxJb094bG5XejlPSlY2RXkyUnhadmN5TVhp?=
 =?utf-8?B?RmFWa0Rkb2FTaEpYN2RvdkpmUGdjbmM0YjgxM3BuTmNINUs2dk83NnQ4U2h4?=
 =?utf-8?B?OWhOVUtKamVpRVVKak5IeGQ5N29WY0xXb1lYVmJ3Um1pblIyRm04VmxqL2cw?=
 =?utf-8?B?VmROKzZUNnZkeWJWSXYrZVR4UVJ4bEFZRE9BT3B2YmgrbXpvWEZTS2JtRzFQ?=
 =?utf-8?B?aVN0akFtMk41dmZqcHdWclNXekJWVVN4WGFXbXNVNHpyTjZDZUFoNzMxZyt5?=
 =?utf-8?B?ZGVkOUc1SitpdkZDT3paZFc3bEQ4ZnAvT3RSbjBtOHh0QVQzdzZaZmV2TGt0?=
 =?utf-8?B?WXNYL3NGYnBEN1ZHb1g3WXRDcy9JeVNVaXVXcWgxQXdQSHpHMGxMNzN4azVB?=
 =?utf-8?B?ZDl0T2dOa3BXVUZSTElEbGNKdDBvbDd3UW5hbDdUb2F5QW1ZMFN4ekJVQUJL?=
 =?utf-8?B?NVBLS3JJTmNWcDF5TVJmK1JPMjRpZ3U3Z2pBM2piQnhaZkR5emlVOC9aS0E0?=
 =?utf-8?B?d1UrOTNzUVllQzFBbHNlaVAzSXY4d0dpNlhWU1lmazFZTXhyN01tQXVXbnlF?=
 =?utf-8?B?WkV1NHB3YUwvak5BMk9Ha1ppSlhVSFFyRVRUQ2lPOXppa1hmSWhGWTBCbUVY?=
 =?utf-8?B?UG9walJKc3pRZUI0ZmhPcFRid1Jib2p5SytpNEdsL2RYNFZTeGd5UFVCL0RI?=
 =?utf-8?B?Yy96OHE2b3FMaU04bWV3RkJmVmlRV2VBMEp1a3pOZXBOdzVPTFJaWmQ5THJO?=
 =?utf-8?B?c2VvK0RaeHBTUi9PYXE3dDV5UVgrOFhxNGtjeUVZdHM3Wm8xamlTRDBSemZQ?=
 =?utf-8?B?eEpldmNNSllhbkxzL2IzZDYwSmx6OVdQVWg1SGx3UTk2QUZGTkh0ZzY3aWU0?=
 =?utf-8?B?NXg3VWgycVkwQmhTMVRXeXJHYkxLTVdhWEhlQTRvWkxvdWFGZ2RqVFFUajFB?=
 =?utf-8?B?V2theFlVTnJubFpCVUFHeVFSRXZFSzV5dnExZGtZUURpVlJWc0E5R2NKbWo3?=
 =?utf-8?B?NHMrenpCaDNKVXZWQWVGS242VVBjSHZoNTZiWTAwKytPMzZ1N0ZXSXNBUXpu?=
 =?utf-8?Q?TYaVXZhBC1aSd12ISdoClOfb1JxGq0Ck=3D?=
X-Microsoft-Antispam-Message-Info: YccazA+32cxb1k2v8YQEIbAxG8MYktCvl8YALNcoGKY0ZaltIZa7ilvsoO/hhqzYOIxtLSWW5nZO5FNY/cL9p0/UwuuwboDFeW5cO+0HrN4UIgvZnG07a91d++0sp91kQvyxleGHWKx0pmJdvXzlk8nX/dCiFtbrgsujJ6BzJI6bNMz8B3DGGumpYL9YDd52UKiqNUW6qXzlC/iMhc2R2gIvQvL1uZu5eyv5LZKjjuoV+N3db3bCb6im152aVDQkDMosR3dCXRhWwVIF4matHYsXgmcoNaYGttpNWVHbnButP9Hpvr7Ymw4py2QjldpetHK+6yrtbbaKYw0wIlKLOkiq9P38n37qJqTZHROYnuo=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;6:aaOnQvaOwEIfmNpz8ow3V6i19EmDfC/03RGF/uWXoZYb6OZCqRZnpyMmoPtOb1GZcKn+WzVWPi2sVwGBV9AgeKRtgHIug1wJUQYywuJbeG0XBUCwuEZQpmNA0ADV95aCnkeZk9iUGC/RYdcGm2fEa9hxxH+8HsxzTiLo1TIPiObvTp8L7zQK2GnMUVtJ6y4FI4xdi6hVRO9ZR2+pGNwSfPQZMFskwbG+RgT43EiMKiNWdhZcHrZFbgmdu8hx2agNNu4Tp04e1xIBd9xduWkaleKxclavVFJ3IjdMB+OXxL+UWuxpJQDi4Yxs8obvCCwAAe8QkmdzFdDmA7QJyJ+CSq7ZsdBMb65YD7CJ4T8WnLsMwNkiuePDjwTBlBy2ldhym9HdY8v/oAugVQ8NsI7GzQrgMLOS2WGShvbVvZzOggMSTilhxmT66VPWXyQ9W8Qigukxp7BJTl49yU9H0b7cKg==;5:AJLBUeGeVZk8dBBsHvbnDoxJsm75I1xEcbJsyYN6zoXW3n9LtBbFs3/n/mv7Rn5CJv5tHeYf5AsmyLJX9ed9KYTwkZ8+xeq74N0N41+QxBOuJqDYu6Zs5g7DsW/emf2CKe0zUtvcED5gLM3OSIMp7ITSV8K2Mu5cxBwtn65tTE4=;7:pK/bzClMY3K9+QDXi716ixka0aU5XnQHGuzD1YfefkCCCXu5dl4uirBb8Zbcrx70Pwjh6+0JsbTHSdQ6hYgS7rC2FfPDsXPOZIIFYyAp25CSPLD4/mgDcu53xnN6lbHnAFWwYru/uComg4HvagaTYGqgDzBR+9L/L2eq0paOs2VOFCxizc6EBmzGvRUgUz8SeGKMdKfjzV9PO0CEdPfPmnoWlFrp4tLaru3Oue9t0o+5guNwUxEouTZcVfHXIizo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:sAlfZ56vfhpA4q0Xzdv9sbGfkYd8Efn0jIrIWmvXnFhE4OF14dDH70/pMnC2zQKhl+WLXACdw3ewOvXLEUV0Cx+GYeWyy6Zb2MGoxP6b6UYPcHLA1bKn/vQtTeXx7U5qmcTfk+7nqQqYPqRIuKJjAta1e5ekFRD9me/SNzj+TzM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 08:30:43.1008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 953ab576-9f0a-492c-2c08-08d60d89b6f3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christian,

On 29.08.2018 02:18, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Hey,
> 
> A while back we introduced and enabled IFLA_IF_NETNSID in
> RTM_{DEL,GET,NEW}LINK requests (cf. [1], [2], [3], [4], [5]). This has led
> to signficant performance increases since it allows userspace to avoid
> taking the hit of a setns(netns_fd, CLONE_NEWNET), then getting the
> interfaces from the netns associated with the netns_fd. Especially when a
> lot of network namespaces are in use, using setns() becomes increasingly
> problematic when performance matters.

could you please give a real example, when setns()+socket(AF_NETLINK) cause
problems with the performance? You should do this only once on application
startup, and then you have created netlink sockets in any net namespaces you
need. What is the problem here?

> Usually, RTML_GETLINK requests are followed by RTM_GETADDR requests (cf.
> getifaddrs() style functions and friends). But currently, RTM_GETADDR
> requests do not support a similar property like IFLA_IF_NETNSID for
> RTM_*LINK requests.
> This is problematic since userspace can retrieve interfaces from another
> network namespace by sending a IFLA_IF_NETNSID property along but
> RTM_GETLINK request but is still forced to use the legacy setns() style of
> retrieving interfaces in RTM_GETADDR requests.
> 
> The goal of this series is to make it possible to perform RTM_GETADDR
> requests on different network namespaces. To this end a new IFA_IF_NETNSID
> property for RTM_*ADDR requests is introduced. It can be used to send a
> network namespace identifier along in RTM_*ADDR requests.  The network
> namespace identifier will be used to retrieve the target network namespace
> in which the request is supposed to be fulfilled.  This aligns the behavior
> of RTM_*ADDR requests with the behavior of RTM_*LINK requests.
> 
> Security:
> - The caller must have assigned a valid network namespace identifier for
>   the target network namespace.
> - The caller must have CAP_NET_ADMIN in the owning user namespace of the
>   target network namespace.
> 
> Thanks!
> Christian
> 
> [1]: commit 7973bfd8758d ("rtnetlink: remove check for IFLA_IF_NETNSID")
> [2]: commit 5bb8ed075428 ("rtnetlink: enable IFLA_IF_NETNSID for RTM_NEWLINK")
> [3]: commit b61ad68a9fe8 ("rtnetlink: enable IFLA_IF_NETNSID for RTM_DELLINK")
> [4]: commit c310bfcb6e1b ("rtnetlink: enable IFLA_IF_NETNSID for RTM_SETLINK")
> [5]: commit 7c4f63ba8243 ("rtnetlink: enable IFLA_IF_NETNSID in do_setlink()")
> 
> Christian Brauner (5):
>   rtnetlink: add rtnl_get_net_ns_capable()
>   if_addr: add IFA_IF_NETNSID
>   ipv4: enable IFA_IF_NETNSID for RTM_GETADDR
>   ipv6: enable IFA_IF_NETNSID for RTM_GETADDR
>   rtnetlink: move type calculation out of loop
> 
>  include/net/rtnetlink.h      |  1 +
>  include/uapi/linux/if_addr.h |  1 +
>  net/core/rtnetlink.c         | 15 +++++---
>  net/ipv4/devinet.c           | 38 +++++++++++++++-----
>  net/ipv6/addrconf.c          | 70 ++++++++++++++++++++++++++++--------
>  5 files changed, 97 insertions(+), 28 deletions(-)
> 
