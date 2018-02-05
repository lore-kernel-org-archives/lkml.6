Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753123AbeBEMyV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 07:54:21 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:42075 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753140AbeBEMyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 07:54:08 -0500
From: Philippe CORNU <philippe.cornu@st.com>
To: Andrzej Hajda <a.hajda@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        "Brian Norris" <briannorris@chromium.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sandy Huang <hjc@rock-chips.com>, Heiko Stubner <heiko@sntech.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org"
        <linux-rockchip@lists.infradead.org>
CC: Yannick FERTRE <yannick.fertre@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: Add read feature
Thread-Topic: [PATCH] drm/bridge/synopsys: dsi: Add read feature
Thread-Index: AQHTnmkdhd8RvGsBqE+ovznsYCM5oaOVsrqA
Date: Mon, 5 Feb 2018 12:52:19 +0000
Message-ID: <1fce104e-7cab-86a1-db49-5306e04d10b7@st.com>
References: <CGME20180204213219epcas2p429434ba0c87a0544dc5294facd80529b@epcas2p4.samsung.com>
 <20180204213104.17834-1-philippe.cornu@st.com>
 <81cb1f26-96f0-bdc6-28bc-4a7bda5a9459@samsung.com>
In-Reply-To: <81cb1f26-96f0-bdc6-28bc-4a7bda5a9459@samsung.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB18DECED86AE341A86E13D9C95CDA2E@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-05_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w15CsWiv027836

Hi Andrzej,

And many thanks
Philippe :-)

On 02/05/2018 11:07 AM, Andrzej Hajda wrote:
> On 04.02.2018 22:31, Philippe Cornu wrote:
>> This patch adds the DCS/GENERIC DSI read feature.
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> 
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> 
> If there will be no objections I will merge it at the end of the week.
> 
>   --
> Regards
> Andrzej
> 
>> ---
>> Extra notes:
>> DSI read tests have been performed with DCS & GENERIC, short & long
>> commands, on two different panels.
>> The maximum fifo size (32*32-bit = 128 bytes on stm32) has been
>> verified too.
>>
>>   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 58 +++++++++++++++++++++------
>>   1 file changed, 45 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> index e9422d05e897..65aeb3f78b48 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> @@ -397,18 +397,46 @@ static int dw_mipi_dsi_write(struct dw_mipi_dsi *dsi,
>>   	return dw_mipi_dsi_gen_pkt_hdr_write(dsi, le32_to_cpu(word));
>>   }
>>   
>> +static int dw_mipi_dsi_read(struct dw_mipi_dsi *dsi,
>> +			    const struct mipi_dsi_msg *msg)
>> +{
>> +	int i, j, ret, len = msg->rx_len;
>> +	u8 *buf = msg->rx_buf;
>> +	u32 val;
>> +
>> +	/* Wait end of the read operation */
>> +	ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
>> +				 val, !(val & GEN_RD_CMD_BUSY),
>> +				 1000, CMD_PKT_STATUS_TIMEOUT_US);
>> +	if (ret) {
>> +		dev_err(dsi->dev, "Timeout during read operation\n");
>> +		return ret;
>> +	}
>> +
>> +	for (i = 0; i < len; i += 4) {
>> +		/* Read fifo must not be empty before all bytes are read */
>> +		ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
>> +					 val, !(val & GEN_PLD_R_EMPTY),
>> +					 1000, CMD_PKT_STATUS_TIMEOUT_US);
>> +		if (ret) {
>> +			dev_err(dsi->dev, "Read payload FIFO is empty\n");
>> +			return ret;
>> +		}
>> +
>> +		val = dsi_read(dsi, DSI_GEN_PLD_DATA);
>> +		for (j = 0; j < 4 && j + i < len; j++)
>> +			buf[i + j] = val >> (8 * j);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>   static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
>>   					 const struct mipi_dsi_msg *msg)
>>   {
>>   	struct dw_mipi_dsi *dsi = host_to_dsi(host);
>>   	struct mipi_dsi_packet packet;
>> -	int ret;
>> -
>> -	if (msg->rx_buf || msg->rx_len) {
>> -		/* TODO dw drv improvements: implement read feature */
>> -		dev_warn(dsi->dev, "read operations not yet implemented\n");
>> -		return -EINVAL;
>> -	}
>> +	int ret, nb_bytes;
>>   
>>   	ret = mipi_dsi_create_packet(&packet, msg);
>>   	if (ret) {
>> @@ -422,12 +450,16 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
>>   	if (ret)
>>   		return ret;
>>   
>> -	/*
>> -	 * TODO Only transmitted size is returned as actual driver does
>> -	 * not support dcs/generic reads. Please update return value when
>> -	 * delivering the read feature.
>> -	 */
>> -	return packet.size;
>> +	if (msg->rx_buf && msg->rx_len) {
>> +		ret = dw_mipi_dsi_read(dsi, msg);
>> +		if (ret)
>> +			return ret;
>> +		nb_bytes = msg->rx_len;
>> +	} else {
>> +		nb_bytes = packet.size;
>> +	}
>> +
>> +	return nb_bytes;
>>   }
>>   
>>   static const struct mipi_dsi_host_ops dw_mipi_dsi_host_ops = {
> 
> 
