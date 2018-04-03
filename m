Return-Path: <aduggan@synaptics.com>
X-Google-Smtp-Source: AIpwx4+xZWd/qlKg//VLmpAbjk9TOnWSFfvKzWWj2j/oIzokMHvrBulyJtKTL6z2m5gsJNvtCIEt
ARC-Seal: i=1; a=rsa-sha256; t=1522716828; cv=none;
        d=google.com; s=arc-20160816;
        b=sTi1QQij1WV+iA+96jyw7VBM6tVGJx6LteSwatveRA8XBQ1fOzso4+orkGn08sshZU
         4+yRHNDbaoi4/CopyRNmqDIFd6Mbh8n+cXzABVwglvNzix1zy7HnHEbXNp4JbN2orpUh
         e9aSt7JvV+V7FVYygQGRy7hjw2p3ZJfsl+X6+TLgYEJAWMpApQ3+GaYgdRPmrCbzld2+
         +1I2wgh6YvOQZRZWVFto47rpg/0zDyRfv6xzCfT9404N+UwhDKCXVL6qgbIWxgViyAfS
         9DcSGamTVx2gSwvjvDTRTEzvW9VMdhJQRyD/tRSj2UqdPLSQYQqTHRi8eS09O9JV3Ag2
         bu1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=Rv5I4trG9rkv1gwvgM0sg/NuGCkGzzEVxTFa/KC2XUw=;
        b=Bg6b07bAaJVeHZBQtEINqeUTCcockhf7R9uXvccuI7HOsPjWRmy1K5vchcmL78NpVg
         Mg6QBCtOBeA2OUPObY6iMEnMjtjI/21+Iw02z7n2sJ2WodhTCd5sLMFAs60cYDNAYJkt
         RIPmYrg7rs8mF3owJv+luTbWRTf6dYkiPnaU11+aj3nMcP+Zd4SB9Qh3XFdtrneUu4h0
         wHVLkJzkbUABElkGdP9FLlhYQlUaLv+KT+oQnQ9pvjkyuyWa/8zarJyNEU8YvnyfUmhE
         CBf8UWGcn606p3YulnLvRRF0V+t6U4OvNS91eL5U3Vs3r7O8zEvEX70f4+uI2E3EEaOP
         sItg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@Synaptics.onmicrosoft.com header.s=selector1-synaptics-com header.b=mzSKTVM3;
       spf=neutral (google.com: 104.47.32.69 is neither permitted nor denied by best guess record for domain of aduggan@synaptics.com) smtp.mailfrom=aduggan@synaptics.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@Synaptics.onmicrosoft.com header.s=selector1-synaptics-com header.b=mzSKTVM3;
       spf=neutral (google.com: 104.47.32.69 is neither permitted nor denied by best guess record for domain of aduggan@synaptics.com) smtp.mailfrom=aduggan@synaptics.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aduggan@synaptics.com;
Subject: Re: [PATCH] Input: synaptics-rmi4 - Fix an unchecked out of memory
 error path
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com,
 gregkh@linuxfoundation.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20180402140327.7715-1-christophe.jaillet@wanadoo.fr>
From: Andrew Duggan <aduggan@synaptics.com>
Message-ID: <a8d419ae-4047-77af-0a1c-683bf1370e6a@synaptics.com>
Date: Mon, 2 Apr 2018 17:52:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180402140327.7715-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [192.147.44.15]
X-ClientProxiedBy: MWHPR15CA0055.namprd15.prod.outlook.com (10.174.254.17) To
 BN6PR03MB2578.namprd03.prod.outlook.com (10.173.143.13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de2392cb-0160-45b6-13df-08d598fd5b49
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB2578;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2578;3:jC9Nx/qzDvCT6k+paMBCf5XXxqYYJiGPkzRvTi6R4Y/N9Jtzuo6LLXp+LDec4osnsN2YSQn5fU1ptfZkkOKMqfkjayblUpFJRZE1Dw1vuurd0plEJxHD8jgiMDuPa0DcIF+ufxYbVJG+2Ye7IgrxOLSwP4x9rv/jk7hFuOd1A1v/uFrttXbNHmOYP2FOHN059T5QMl2pOT40lA/Gc7IoOsmKsRg5aQNJ3bXA5gARf+0eZxO3GlagTqy3NIp4o4Bv;25:n5s9goDHxIO71OulbugLb4wpGns75PPPIpIwwpdi1Xjjy7f+eIrVmIu+GKB5oZkbvTP+0G8N31yOwOduNXhPioAcWzDwg+24qDh8QoR3kaIaBrg1j7XvQ/baZ8FvMG+S2gdLhZLCWzLE2gOnrkvEVPhFj33TNm09+ejkjISIdSKBctruycKrbsXIUcrAflcReXAHHEZ1HaLmn+8EjXxULq+PRJAFqwGaytxw016hmwQHJbpSK4uoz62f4H8UxCg+/il60WqKubFTobcjSEqRp9dDHaBkIMYxhLSi6p8ikoY4tGeX+5pvB/x1hDfHP4ACqgRlP/8nXawtQOgM5D8Xiw==;31:10e/Y4hVoeTndo485AwEewrT/eSCaVlxDj7tkP3Ac7NRAvGzgQ6SJpRanA3V6HEQksCoDrcXnf4d3YeV6o0EO9QRT5JIFIR0tTR0RBfqvu0aSAs1XwKMZCuUekJlXu13gobIZ23eYEF1QrTFo7qmA7LLZlBr/93oRkK8gKkO0sjuCDih8o/ARqbLdXuzRa/cJqUyWZ+PzZ63yEaunROcfpMXXxxi8DwP4o61G3LjdMI=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2578:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2578;20:LV532moy0QjLibPT0EhVYdZAiFydCqjGgxMH8KVTdEl8b6F/PyotnpL07D7o5OldbG847rTBpv9GtCyD4sal3gW7CtdAh9wbddySwIwFz3hCqKl5YNHwGDPWP0cptgqa8de3QEuGi005UIl3SCQw9xtmQDQHUKH59fFyrnFPbI3pJTIR8Wj24Ij7pcuoB3FgjF6cCfz8V/7oo7eaP4zw62hunuy+TasZDjqyouCtm6WlhDbv6DPZmdEFrRrSzKNuPfqO48gX+08473O7SF0hmOBqfxu1+tPkkHld/wYhzo6+oz/7xAc+gZaEaq7j9Of3pJCwrS1sXtxEDRZYDvPQ3bAHY7sNIFILyNHAk8iptx2AYHKmeX5j9uboODUZo4VveKQlaDkfP/AS8/2vEkzzLPDTwsfcuuhI1u1eBurHV1VwDpOJXomGGSZTJ3h2AvrC0ATMT4RTAyABRU7uJ9cAZQlgS8yaCg3wFm/umRvcJt+VucQEN/OGNgb9MkhPIyfT;4:3m/sodRG/YuyHDMNHrMGKp06qdV24fvh87+we3UcqaXrsvC1E6JzvOLK7Kg5Cf355OgajcZf8ii7kpEyXrXkNoRiDlFHXh6jQnrUokm1GMKW9E476KfrozOwP7W/Jo4v/AcXhOBTTfU7WuShN9H79X620d7q2vjRoutP/kDCE4o6sja+gA6HDkZydTtLaMPLX0JqzPqY7li4kbjVL9wn6BsSDH/pvDBHrGVa/msVUuydF+Lsg+pZd/jnrMH/hMiRKDlx9iJmw5GTOPoz3Vb0qqr4bulewLV1JUsnLASkz/3j7INX1Q0Viu/ypONMILGs
X-Microsoft-Antispam-PRVS: <BN6PR03MB2578CB324DA9F5D4D7E9E6E2B2A50@BN6PR03MB2578.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(155761271638844);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR03MB2578;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2578;
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39860400002)(396003)(39380400002)(376002)(346002)(51914003)(199004)(189003)(58126008)(305945005)(86362001)(36756003)(106356001)(31696002)(31686004)(7736002)(5660300001)(230700001)(6666003)(64126003)(229853002)(65956001)(66066001)(186003)(47776003)(50466002)(65826007)(386003)(53546011)(6246003)(16526019)(65806001)(26005)(316002)(68736007)(16576012)(53936002)(478600001)(11346002)(59450400001)(956004)(486005)(76176011)(476003)(2616005)(2486003)(97736004)(52116002)(23676004)(52146003)(77096007)(8936002)(81156014)(81166006)(446003)(6116002)(25786009)(3846002)(8676002)(4326008)(67846002)(2906002)(39060400002)(105586002)(90366009)(6486002)(486005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2578;H:[10.4.10.103];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjAzTUIyNTc4OzIzOk5zUHQ2bVQ3ZTJyN3AraUZlUXZwNnRsV2ZU?=
 =?utf-8?B?UUFoNm90TGFIYzl0RVpJa1BaenE4WVFQYkhsZFNEZDYyOEt5SWZ3OVZqK29W?=
 =?utf-8?B?NnZyR2dNc28vSzU5ZTU1WlNmOHl0OXUvM3JrdHg0aTFxd05CbEs2UzVMOHU3?=
 =?utf-8?B?d0JWc0dIWWx4enA2QXdTRVFNa3E5RVVFMGVpZzQ1MHRYN28xakhGeWtPUUIr?=
 =?utf-8?B?Yk9JdlRPbHlMZTd5MVA1VlVJSHVlVW1TNEJlRTFod054RFo3U2NSWG10RVhO?=
 =?utf-8?B?WGE0dGQxeVhqTnByVkFQWVM5VFVHMHhqbUZjT0hFN2psWUlLTXovTjBHOXJ4?=
 =?utf-8?B?UDFsRUUyTElMMis1NGVnVy9Wdnd1eDBBMFZ6TGJoNlVEaFZVaW1DWFNodVlF?=
 =?utf-8?B?dWZTRExSdHdsZWIvNFBDQVBDRTIyeGg3VUhFWm85WWNDUytxd0lIZnZLdHpM?=
 =?utf-8?B?NE1jMTRYQUVTNTFUcmMxNkZ2L0trK0NIeU1RbnBveU9wNzNCV1IwTlJFRmVH?=
 =?utf-8?B?cnhML2dVZHBwdytqL29OQVNLQW5US2dIa25SbHVlT2tEelRvRGRiY001RzB0?=
 =?utf-8?B?L1hubWJmbmx1WUI0cEZaSFlRQXM0M2hDV1U3WHFnZXFvcXRyMVd4akF6Y3dM?=
 =?utf-8?B?TjNIOUZtMS92SGxQbng3eGJiMGZlcnE4OFU2S2I4SkRZQnhYWXdtekhQS25P?=
 =?utf-8?B?R3M5bXgwWTNBNk5ML0NlcXFtRXZnc1lyOWlxYVZQTGxwRVhIZlJza1ZNSmVR?=
 =?utf-8?B?K1ozd2lUNVNzY0JvbWJEMmI3bnlQR3ZtNzJ4dm1lUTM3eEU4cS9vVzBha3M2?=
 =?utf-8?B?SkE5b0FOSkZlZGFsN1VNSXJZZlU3cVgyTU9KY2pyY2RNTllZbjh0ZFc1K3BX?=
 =?utf-8?B?M3cxYWJSNnVtdG1namVKa2tUOVJ1L0F2akpyWjhaSUJWby9XMkkrOGVEWDZU?=
 =?utf-8?B?bG5WTWxPS3dNcWJHVGl6ZkMwczdIQkdUQklPbkw1KzV6dEltY3l6UWU2SFV5?=
 =?utf-8?B?VEhqdzd3c1YwSHViSlUycHJWemxTdHlNZnZnWVNkeUxScUIyMExRaC9YU1J5?=
 =?utf-8?B?NG9ud1ZHcUt5WEVwbkMySWhCNnB3ektPeWxPcTBiczJYTkQyTHJIbWFQYWVU?=
 =?utf-8?B?NThxTUlxSHNaSnBHQ2xiNUJiQm0yemgzU1JCNXlNaXBDYjcrNWJXT2Y1ZHE1?=
 =?utf-8?B?ZHJHTUFCdzUvQ1Z4YWtVbGpkUjN4ZC9za25NVnlXSEFiSXE5TW90QWo3cDln?=
 =?utf-8?B?ZWF3RFdpQzl5bmpaRFVRT0pjckRJS2hKRlZpUUtMQ3NYaUVLdXZocVFBSEky?=
 =?utf-8?B?RlZSdTFiMTErMVhVc3BWS01abXJYY2Fwb0pYbGpPdWx3MUJsSnd0Vkx6aDFK?=
 =?utf-8?B?S3NSQVJFUHpGUi9lYUUvbnN3WEdLanI0VU5XVDgrVWVpcFg0Y3U2UmxXdGJr?=
 =?utf-8?B?S1p6MEtwMnQvazh3Sk9jbkRhSUkwWm5QenJDbTg4L0Q3YytHaTJwTWxITGtU?=
 =?utf-8?B?blBnS0JDRGVDTUFlZGxrZ1BNdnFmNUhvN3g1Y3o3SWNqRWsyMkd5ODlKN29M?=
 =?utf-8?B?NXMxNUVYQ3NJRHhFOWlJNC83VDlkN1hVMWFHMG1sK2htTCtFNldaYXFIUjZX?=
 =?utf-8?B?dlVUbE5MbkRMQy9zQlN3TzZvRG1nY2ZFMytCOUYzeUJZL2JnRUVGRFlxQmRQ?=
 =?utf-8?B?ZVcvTkRxTkhwNjMrblBOMHRyTnYzczZaRy9EWWIyNk5EVXVFc1dvYk4rUXpT?=
 =?utf-8?B?SFROazhIQzlybmtSenZDdmcvLy9GWVZRKzEyYzZ4N1JtblNINzdSTmliTE50?=
 =?utf-8?B?eVYzMkJzVS9rQ0Jxd3FYM204anhONytWcWtkeEQwTy8xREtPTUV6bkw0Z2Nk?=
 =?utf-8?B?YklFdWE5YW5YeFVnd2RIUksvQXBzcDlxTHBvRHM3UytKK3RBRlZuM1VJeVN2?=
 =?utf-8?B?d2gzbmlMb1NLV3BaZ1NiMGlRVDQwRlhNeUkrQ0MzZVY3cDZBWHFIVzVGNEZ5?=
 =?utf-8?B?ZWJMQ053WjBXNGFFcjl3M1I5c1hPRjNaa0lIQzRwUy9KaElyRS9RMUtybEJS?=
 =?utf-8?Q?MkKwLV4rdoKuJLAmYtAeOwbsJ?=
X-Microsoft-Antispam-Message-Info: nZ07p/G8SQ5VQRqtMHeCAufyDz3DNoBvda49SKDIYMGv+u3Jh7hFuz8yVaOQYtHXM6QrpB4zXbsgn1YkHzu54kZZS8yTJC93NxzMjLQZVafIXbIOxPDi40Wg5im++OKm9+5ZDrk0o/szj/uAWFvpzExScx3yLlcSOSixnsYZbJdbwbmvOeWmcPJmVEO0zMtq
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2578;6:JHzdvyz30ZXDqHQvtuYQEGbVw3HGPIUUrfN9M5TvDYZqBtZAaHi1OYLsfBxZMqL8fVzfuHpMGrkJkD08THtFFcakre4iLmFZThgm8YmhFvpyYyE1MOnyNJLuQTYAOQNpDacsm3AI4Kn0YIMFxh8r2efxwISsunUMS8G7mL3Y+07VDmNckTJrpODe+ZuSwlyKWBF4aBMVAeDXh9n8FHyrUflVlBYW0hhyqUj2Y4VT65j6K4cioxhTY8IblpiPyIICfy2DUS6bwRIMbRb8HTkOPiVdzhUQ4zMgkh1D32GcwH6L23R/HPGXWZlPRAcHpf6ACbAcUoSgT66zeObZGVXy8RDFRD43Ie/rOjTzt1pcMJq3c/7PRy7CPnv/Bc7nMuqkUknurnBu7M6tJvVupZdYRvONE7V51+2Yw6zy0NadzIaPf0jvEExH8qw+ePzOqqOmwY6nLFKDYykhOKAbySuNsw==;5:Zvv420JjteCBuEd4gVYIho4864qox9lZxUvSZ3ZNB9f2Ift1QhsqcQ/KiCuOEaKJJN3CrFIstWRmTTNS2nQazuq2oLTlsLcRjNb0bo02xJoNESabz99S6xuVVs76jXcHzkQQbetrcTvvsH1iJZZHNCk7q8OM5mUr8qSmzhp4ZZI=;24:5iCQonFOxQqtBk2GpX8dYAVYBejCIAeg0+nYjNgZGi/eWKoqkSO+r4zoCCXPGF6ZgDk9vKjOuV3d1Ut9lCyBiKA5NhZ/fGMU+/BYkZi8hIc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2578;7:eD1aYzYISxOk3G39NCuDnJ5D/nBUsshH8DqEaCGbXUMIuFuK7WBBxzLNx5Il+NaRZcAdxy/F0FU3l7zyww02bwXiCDjYqU62FUpONaUToUeZdTGM8E0z7JJiRcaA7t3H8JSzn8bg78JgQCs4e8i2osHevYBXflPjqVcTxDPntSb5bqrsPj++f9H5zz/xYCaTRUJIbGxTGA+DE6zrR3qTyMfzz1OWtKRkz4Gv5fBIFTySewT1Krny/626LrsWpwvR
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 00:53:44.7329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de2392cb-0160-45b6-13df-08d598fd5b49
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2578
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596643408771291983?=
X-GMAIL-MSGID: =?utf-8?q?1596684321722782106?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 04/02/2018 07:03 AM, Christophe JAILLET wrote:
> When extending the rmi_spi buffers, we must check that no out of memory
> error occurs, otherwise we may access data above the currently allocated
> memory.
>
> Propagate the error code returned by 'rmi_spi_manage_pools()' instead.
Yep, that definitely looks like an oversight on my part. Thanks for the fix.

Andrew

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Andrew Duggan <aduggan@synaptics.com>

> ---
>   drivers/input/rmi4/rmi_spi.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/rmi4/rmi_spi.c b/drivers/input/rmi4/rmi_spi.c
> index 76edbf2c1bce..082defc329a8 100644
> --- a/drivers/input/rmi4/rmi_spi.c
> +++ b/drivers/input/rmi4/rmi_spi.c
> @@ -147,8 +147,11 @@ static int rmi_spi_xfer(struct rmi_spi_xport *rmi_spi,
>   	if (len > RMI_SPI_XFER_SIZE_LIMIT)
>   		return -EINVAL;
>   
> -	if (rmi_spi->xfer_buf_size < len)
> -		rmi_spi_manage_pools(rmi_spi, len);
> +	if (rmi_spi->xfer_buf_size < len) {
> +		ret = rmi_spi_manage_pools(rmi_spi, len);
> +		if (ret < 0)
> +			return ret;
> +	}
>   
>   	if (addr == 0)
>   		/*
