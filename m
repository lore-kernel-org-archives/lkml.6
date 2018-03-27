Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELsKNBxlO8LKHClHGQ3X4DksaoIR6HGqMRcp0TWEVVrOHk8y/pj2EgtPg2z+5dBwDsWwqT6M
ARC-Seal: i=1; a=rsa-sha256; t=1522163861; cv=none;
        d=google.com; s=arc-20160816;
        b=K9sZUoYN03dFERcKmiowvzn1bWKWVKBmWdGzD2jObe5dUdIHyt8D7e+KwyExyYhYyy
         Kjy5SjJS7yXhGo0pY/VvchBZ1UrlG0mgVth7pDHOCd5hdsYsdqF2wzB4SwTglvFp9yJd
         rMrt0qSpqQReXVKQ7nv6+qTHVTgYMKRFsawQnbwCz0uoEfJ+OgZMG6dUPCpbGD/UafyZ
         +UwJMCCosSL4Iue/yxdD7XYo0UWNhzYSaTUzekP+aQz1+cUaV2jsFaNeHQfeXnq7p0P3
         MEMkVQA6Je87Qdl1Mqfk8Nk0hAO9g2Z7IrfIZpbGKirhpS9E3S3HFRaili0DCFqVtkPK
         A6Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=cyjTHj2HKJ43REfVGsDH4fyr7giTKjC0X1nO8//N8sg=;
        b=m/xb2sAk8W3MyuZWilfUqgjZlZNbb2T0rRJps/Xj5SHvMHuaNR65Xdkk8cmWLq7n8C
         aOLvNAFD/rI+W5gjdWuGRYoJJaOLIvVF9+SguHBha7LxL5K3jYOBw2UV3j+WH2gcHHFf
         x0O0F6j1qDbAwVvMCogpVMkxMpqOuVyAuuZQhJRW25j8uF+LpqjwLU11TcTN6MeSo6Zj
         6f19h8GKnaBarrV1mL5PuvvEntce4871cB9KIE5Gjh2YxSQjoLpW6PEe5/3DqGjRtdBp
         fVF3fGqhlmbBcF62AyfWYqjOm0T3+Bn3+LubosFVWFZI0Jcjjvf2+Zx5lhZfgJagpNuQ
         Vp5w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=K6DQ59rn;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.1.137 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=K6DQ59rn;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.1.137 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH 03/10] mm: Assign memcg-aware shrinkers bitmap to memcg
To: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 akpm@linux-foundation.org, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 hillf.zj@alibaba-inc.com, ying.huang@intel.com, mgorman@techsingularity.net,
 shakeelb@google.com, jbacik@fb.com, linux@roeck-us.net,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163850081.21546.6969747084834474733.stgit@localhost.localdomain>
 <20180324192521.my7akysvj7wtudan@esperanza>
 <09663190-12dd-4353-668d-f4fc2f27c2d7@virtuozzo.com>
 <20180327100047.gj4gtmt3necmtpzw@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <830e05f4-5105-be40-6414-9a90b610d5cc@virtuozzo.com>
Date: Tue, 27 Mar 2018 18:17:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327100047.gj4gtmt3necmtpzw@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0189.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::13) To VI1PR0801MB1344.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a1d8a6c-eebb-47a2-d3cd-08d593f5df62
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1344;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;3:IsLuDRIf1u5scsrXVCwTKKVw4TQVEv1j+V1UuyFNyrqngnTDXpHwEvEFBLhWzZPPl654UR0T6nU90F/udJBxbqCtdwCZN1A7xFZSJuZSgXBT3wn2jWbzlqsq43MwIYsN6s7L2hHYN6JMhPLP0KsRQJwHUDEgJzrkGEjXW2QKfGOLECKzSDXdVKRvqbEBn6CBkxWB+RAPFvgCgWd6aCyoZ91wS09Z3K5j3VEM+heZDSr6Lok3ZOAiJFttGhAgIGCl;25:5a2T2eVLXSnyhpUaNVQXuTuMbfuC+P1hHgD/lV+ZNFO8jziRidqzFG+ZKyUkYK67AADsD/MACAmmpNQY0hj1P2DVqLHLg7+Er2o1hB/Ercd0+4G+J6qS5bzf2DF43aLV08xYLEiW7Q1OhR1IuhJspTyKYOgnK0Oca9VzGr3+2Hc6cJO4+wbaG99d+zyEx0oAxw2GMTzfvFaS9rKbNFfscPsK0sIKoWibf7YmqhyWPebjOfJDDNUsBLHUtMzmb409VUdvrUy0mlBiyZgtCL1PcfIvx3h8A2BCdVptgyxfFvHRsPggPnDlTe/3bn3RDl1zY0haTeZp4F2HXDP/+mw6Hw==;31:Lsn6whyP1WfDu1AF4J2yZmYl2qEbWbMalYJ8eWm/s/DmtSq9knr69HMypheIeVbwY9yFdS3mMTvy4SjM3rKnBYt2CsE01rPTzV8yR4DrxgBKRJyluahYAQk+mouap5ZURGmB1rvWGbuyAtOCU0IN/D5IFLmR3pNY/ctKwXPrh42qwPkhdu7FK+xvdiUbwG/7J4MS2hFFBu1eeBN3OuUxLN1Lfnp20H6LvHf4KTD6BYY=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1344:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;20:UHU9j3j/X/O/H3YHnpyWjDy21sfId4tI9v0FxPafezKsFBrQvRnOMgfNqYoEj8Qhdq1owCpoIn70H80O3CY4i5aBhVSwBO+Wj/PQeN/lSgxUNYp2RPOGhd0YrFDKHBvcGF6IO7w6etVax4vQKWiIhCyiQ4+uFTub8xEiDW9jXLeU1JrEBQwpC7r7Kj9KXKpQtkWmKx/KV66fMGUcXXL2TOnh5puUNnoWFXKhDyb2yIeW+i3NfBY11miNEMQApRiBoIAZ6bm+wIXQRySPYRuqmf8V75oUfHauPMugz96xb87jK0YdPWmCGXcNuVextVa46gZIwt+GQ6H9rUvgolWMwunvIct02pYoRsQ0mv1hlFHEUA8J7RjDogPPbdj5RK3iTUAPOoxBaBTzcZ7+TFnOGJk+khBY6NY0B9OKu7wu/XqWkUo3VPlCwscyU1yeZmy57M2/Ve4ZZ6HvLuqwvkiC8ssz/NtdgNiDSwvtu2NAWfHKt3pyN7//1g1gpKaumCXb;4:XZN7UdPrXeb0NlJuDkRFU/FdZpzmyx/WLU241QvI8pp9IJ23g9/6UVgVhJFWGsJluPoO6Y1zWXEA0LbY6pZWJbJ0Irt+cJDzDCItLHYuvCPBNJZefjGo4rDldgK4Va9veGpUyhrGOrgX92KZ0cRo6tKu83pi9SDiAHs+0QZ4MX4/lxX2RZaOKOOSTah+Ir+sbvT61nStbiLaOt51/yChI4PVWFehDU4xyqwbbjJDjBL/8E5c8GhUfZFSSkZv8PSQoUKLYshJlmCNg5TCQvuMODCO6GHYwNOURHTQmBgO/lJcnbtKLSKmvRwvdnqpN6E9
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1344BD099A7FC14DF08D5735CDAC0@VI1PR0801MB1344.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR0801MB1344;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1344;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6049001)(346002)(396003)(39850400004)(366004)(39380400002)(376002)(199004)(189003)(52314003)(57704003)(230700001)(2616005)(76176011)(478600001)(93886005)(106356001)(316002)(6666003)(7416002)(2906002)(8936002)(6916009)(6486002)(11346002)(36756003)(476003)(956004)(446003)(65826007)(86362001)(58126008)(52146003)(229853002)(52116002)(2486003)(5660300001)(23676004)(305945005)(97736004)(6116002)(16576012)(31696002)(3846002)(25786009)(50466002)(55236004)(68736007)(4326008)(65806001)(7736002)(386003)(105586002)(64126003)(81156014)(65956001)(81166006)(39060400002)(6246003)(8676002)(16526019)(186003)(53546011)(26005)(31686004)(66066001)(53936002)(47776003)(77096007)(486005)(486005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1344;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDQ7MjM6YXUvSFh4R2FPWjZBTHJwTEEyRVozS1Rn?=
 =?utf-8?B?ZVlEM09iV0pyeXpWT3hmandobjhTOGprUmtnOVVJL3FNS1BKTGlUSDA5cEd1?=
 =?utf-8?B?SXNrcCt6WTI4Zk5Hc0RpVmdSb2xYYi9FMjUzc01rK2F1d3k5R3VjdlhHa1Ju?=
 =?utf-8?B?MWRZY09jMzFBeTFHK0FxVnVvT284SEQxbjlRL01VUGUwOHUwVVBGM0tnV2l2?=
 =?utf-8?B?RkFjQURUN1JsWE5NclFqK1Uwc0FYUC9lYnE0YmhMOE85blJFYWZ2dy8xYkkr?=
 =?utf-8?B?Mnk0VlUxamU4NS9MWlphWU1PNHJMYTZUc3NFR2F6MDFaa04yRU9LZUJITVNZ?=
 =?utf-8?B?R1Z1a3FuQkVSWDNyeUdFN3plSFVML2dwWVdOb3NhaEhXM1NnYlVUZkI4Q1BZ?=
 =?utf-8?B?cWl4ZXVvNUhTcllCL0dyc2c0Wk1qZEVWWFFGUGViMDhYVXJLck9EV0Mwd3Vv?=
 =?utf-8?B?dXhXcDNxM1Yxa2Znd3FSMDArQkNJZFFZWllSenEyV2J0ZDlCNTE5ZEtaQldT?=
 =?utf-8?B?RnJOT3JxYjBlUXlPU1FYbyszK0VTbU93OW12QU9uWGJPdUNvN2o4aTFJcksv?=
 =?utf-8?B?MU5JR1kzcWpjWkdGODRncUw1NjhvTGFPMHVsZllOWFVDMDA0Q1YrY0w1Y0dL?=
 =?utf-8?B?bGJuSzdoT1BTdWhGc2FQQkhVMURnM0xwSmVWaVJiV2FPOEJVV3ZQSUZVYnhp?=
 =?utf-8?B?Qmpzc2t1Qm11aUJSM1daM1hYbE5HZUFSUFo4aHc0bFl4VElYM3pCOFJmSnBF?=
 =?utf-8?B?S1VDS3RBR3JWblRFeG5BVUtOS0lQZ3d1MEpwRmlEbUxOdENoaHd3TWVHY1o5?=
 =?utf-8?B?RzRwUGs0cEpPVWlnSDk1cURKV09paFZEdXVQOGpNdmhUMlk3dEx3cWVoUEM0?=
 =?utf-8?B?L09kS29wOERxbFRCTkdqMElRYWl1UXpTTVhmMDZXT2ZBL05xYllVMGdiaGcw?=
 =?utf-8?B?QjhNZ2lzTUwzQWlTMmNVQjVON0RsTndiVGEzaHlpMmpLUGFvZXBTcSs2Ym1t?=
 =?utf-8?B?VmRpRm54ZjNMTmdWSndpUVZqWUdwU3BJQmpPaXhxYTlybzcxckluczdWNzlD?=
 =?utf-8?B?VTFYNlNNQlVPS2tvNE1yb05RMGdscTZoV05KZmN4dmNjN252OVluZ0xXUzh2?=
 =?utf-8?B?aEFmdmJFQnFqVkYwRy9qZVZzOHZyR0ZQQXRyRzl1YndmNTc2UnZSdVplZXFn?=
 =?utf-8?B?VUF4TjJyNW1obFB2VTFVVnRWRkRkZm84MkZnamhOVTNDbW5zVitsbnFYRTBB?=
 =?utf-8?B?RU1qS2JkejdqZVhKb1JyMVYyUWtqU1JqQm5lTGM2OEc2a2lHSDdFcHQ2a3ZZ?=
 =?utf-8?B?dHdwbktsdzN6UC90ZGkycjg2RWErQ2F3cnlkcXB6S0t0T0FsRG1xN0tXdnlz?=
 =?utf-8?B?SFB4NVVicWY0YzV2SUsxU0RscW94N3RWV1V1eEZLci9FVzZpM1VobGR2Q0Mr?=
 =?utf-8?B?UzVuSnNaekR5cmQ4M2UzR2xwMUdBcTBxZFcxbUxtd2cwRGxRM0R5NGp1STIv?=
 =?utf-8?B?NTBhZldmY203YnlmdzVzQVJGaklJMlR6TDBHdmxQMFZpdDVYc3c0TW9FMTky?=
 =?utf-8?B?dmx4Vkd5QzRBK0JGVVNFdmcxVlR4YWJmTXRwMFh3NTJaZWRVTzNqMGoreE15?=
 =?utf-8?B?am5UR0xyYWpReUpyVkl4VWtPL2U2U1Jqd1NSRnNKYytHL1g5YkN0aHh2Rm5L?=
 =?utf-8?B?UTFoRmx6RGV3TVFISTlNclp1eG43ZEl2WVZkaHBEZkNTaThqc0hYL2EwZnRC?=
 =?utf-8?B?RHFzTUIzMVBoNEZJVGROVUppOGpEMFk0YWlrUWJaNHEzdFZzRWFvbGNZeUxr?=
 =?utf-8?B?eGl3ZURLVndxOHQweDdXTWpjaDVudVVodVUwbHZjUy9ENUIzNWF1dTArWnRi?=
 =?utf-8?B?YlljNm9pRk1ibE9mOXZsekM2dzVXQTdMNE1sQTU3WWF1UmVhZ2UxNGJWMyti?=
 =?utf-8?B?K2ZmU2dNSlpTMjd5VUlVa0tGazd1d3FmY3huYnRSUjI2MUF0ZFJ0RW9OREJ6?=
 =?utf-8?B?R281ZnBwT3Y4TDgyb1FQUzlBQkxnOVUyN0k5MHpydW0yQktWa24rSjdkNmZE?=
 =?utf-8?B?djhqUHhzdnc1T2ErS2xscko4Tmoyd29DYjYrdDdoVVJJTHEyTW1iS3RuWDFz?=
 =?utf-8?B?V3ZNR0UweURaNjBNWXl6cy9zZGE5VUlmYU5sdXArMDVZbytWaEcrbjBjS0Np?=
 =?utf-8?B?S0VvSnhVeEQ3REk4WUNwY29RYzN4Q2xIelREK3pOWnhrWEZ0NWFQcEMwc2Rs?=
 =?utf-8?Q?Ca35NVsSC210/Vn5OWi2?=
X-Microsoft-Antispam-Message-Info: 0njW3nyd5UBiPHsbh9qnisf5UYnsjrFta3ObG+ITDevgMmz+rf9YnZ8uaoNuFQV7rYkYTxxGlqLN0bKH7IshGbkfBbFEXKZeGVtI9iVi8hgEXBU69XADWOXR0XKU0utchX1pgmDvx8lHL5Kc4bdSC1xApfc49QA3NowvHiOztUgj3q84ARoXfjLVZs0A9BA1
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;6:kcgjMRfpqmEIZ6hm2JAXJijBio3dSJoDFiZYO5VV9jK2ioYvWPYBnFQxHVstQTubklkoR2QWbGiRdwpm8G79Cc5CmLlVlVPsETkQQpMDOhY8fNM0iWrIn8+WuhyNN7aukhSuBTgCmOUtHXhcjySC8hY+3aCGsUe518cB/PKxt5T+bmjCp3r4jBAANXARE4jNfhBpu2IsfS6VQVifEJUUQozCc+Cc9ltdaIMmTf8NTDrSpV1cAiKwS5XV1+QRXIrW1LAUe3CqaOXuOtbrTFv5/f2kqbLJGJkrdfJgnx+ZXXMd85dxNpIlOdmNLNhRZEU1goHZLb+SxVjQ3Ae1ov3pNJY14OXaTw5RdxR6fzi+N8fpd6WV18Xr20X19IBIXwKwtJleEhPf1NzFb6b2DRGzb2K+LoFaSqAgV7RJQvVUmr9UaPzszuzRNM9QEXsNYpNL+LPaRpi2yYKWlleoHZlb6Q==;5:D90o7PaZij9JiPqIZciHTsdtD9usJmFSEnFg/HWC6dJDe+j9Dw5S0L/3shPDq4NgirbA4iLGVN2bNrwkcRVLy+DMWej4oe3OrLeEJpxdys1QQX5B+8IySmAxYqi4PzWbD8Eus2HSKB7dUUY4UNEMJaGv9yIlFvyGOmSLJqVhHf0=;24:Z7GYKXiogRQ1tMBBpKrH1SOglpdNT6Hj85MdSoiGlOASmiDSd/Ue5hLxFNjCQ1+7JVWrE2N9l2hf1RZfTU1q7Qn2keQpGPkyMZXiCg4mmUQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;7:CLaNGyRHsDYUeAlvneIdBePX+MQ0w3k8468tLUEfxqYjm5WDiIA/IIot15z/iNVA2vFbYNhRKerMsvYnCSeSPdhHREiqVd10MgmlQ9ajpnZ3ueA5TQDoLTBoicoVC3Q4MmrvHmjJBJVzMD/7WBHO3srwF/Ld3syucWlSDkHi4IdV4QWvpTed4a4WpGaDCgqX8UkG1hDKG5xu66HQ0WClBWFpaKs1FkOZuSPO3nOwpqYWPScBFUTm4G68lPW4HrvQ;20:BmBpx8zd8e4pGRWsNd1qyKKM9/7oDRACTpw/f+9dPWIUkTgXC9vSkwtEDaNIaGcyYIReXuVky+j0SdAOsQVyjrals2PltkAiNuqzwmOrusYKQ6IRCUIT5j5JHC+Mhu+rJ2r88zHeHcpaEZax6yotH05FD5hp54lgm6019+3X56c=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 15:17:34.8109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1d8a6c-eebb-47a2-d3cd-08d593f5df62
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1344
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553622756842955?=
X-GMAIL-MSGID: =?utf-8?q?1596104492784712326?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 27.03.2018 13:00, Vladimir Davydov wrote:
> On Mon, Mar 26, 2018 at 06:29:05PM +0300, Kirill Tkhai wrote:
>>>> @@ -182,6 +187,9 @@ struct mem_cgroup {
>>>>  	unsigned long low;
>>>>  	unsigned long high;
>>>>  
>>>> +	/* Bitmap of shrinker ids suitable to call for this memcg */
>>>> +	struct shrinkers_map __rcu *shrinkers_map;
>>>> +
>>>
>>> We keep all per-node data in mem_cgroup_per_node struct. I think this
>>> bitmap should be defined there as well.
>>
>> But them we'll have to have struct rcu_head for every node to free the map
>> via rcu. This is the only reason I did that. But if you think it's not a problem,
>> I'll agree with you.
> 
> I think it's OK. It'd be consistent with how list_lru handles
> list_lru_memcg reallocations.
> 
>>>> @@ -4487,6 +4490,8 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
>>>>  	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>>>>  	struct mem_cgroup_event *event, *tmp;
>>>>  
>>>> +	free_shrinker_maps(memcg);
>>>> +
>>>
>>> AFAIU this can race with shrink_slab accessing the map, resulting in
>>> use-after-free. IMO it would be safer to free the bitmap from css_free.
>>
>> But doesn't shrink_slab() iterate only online memcg?
> 
> Well, yes, shrink_slab() bails out if the memcg is offline, but I
> suspect there might be a race condition between shrink_slab and
> css_offline when shrink_slab calls shrinkers for an offline cgroup.
> 
>>
>>>>  	/*
>>>>  	 * Unregister events and notify userspace.
>>>>  	 * Notify userspace about cgroup removing only after rmdir of cgroup
>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>> index 97ce4f342fab..9d1df5d90eca 100644
>>>> --- a/mm/vmscan.c
>>>> +++ b/mm/vmscan.c
>>>> @@ -165,6 +165,10 @@ static DECLARE_RWSEM(bitmap_rwsem);
>>>>  static int bitmap_id_start;
>>>>  static int bitmap_nr_ids;
>>>>  static struct shrinker **mcg_shrinkers;
>>>> +struct shrinkers_map *__rcu root_shrinkers_map;
>>>
>>> Why do you need root_shrinkers_map? AFAIR the root memory cgroup doesn't
>>> have kernel memory accounting enabled.
>> But we can charge the corresponding lru and iterate it over global reclaim,
>> don't we?
> 
> Yes, I guess you're right. But do we need to care about it? Would it be
> OK if we iterated over all shrinkers for the root cgroup? Dunno...

In case of 2000 shrinkers, this will flush the cache. This is the reason :)

> Anyway, please try to handle the root cgroup consistently with other
> cgroups. I mean, nothing like this root_shrinkers_map should exist.
> It should be either a part of root_mem_cgroup or we should iterate over
> all shrinkers for the root cgroup.

It's not possible. root_mem_cgroup does not exist always. Even if CONFIG_MEMCG
is enabled, memcg may be prohibited by boot params. 

In case of it's not prohibited, there are some shrinkers, which are registered
before it's initialized, while memory_cgrp_subsys can't has .early_init = 1.

>>
>> struct list_lru_node {
>> 	...
>>         /* global list, used for the root cgroup in cgroup aware lrus */
>>         struct list_lru_one     lru;
>> 	...
>> };

Kirill
