Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752386AbeBHLDO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 06:03:14 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48432 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750881AbeBHLDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 06:03:12 -0500
From: Hugues FRUCHET <hugues.fruchet@st.com>
To: Hans Verkuil <hverkuil@xs4all.nl>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick FERTRE <yannick.fertre@st.com>
Subject: Re: [PATCH] media: stm32-dcmi: add g/s_parm framerate support
Thread-Topic: [PATCH] media: stm32-dcmi: add g/s_parm framerate support
Thread-Index: AQHToDxmojgOuNX9wU+RuXKNw42fMaOaR3qA
Date: Thu, 8 Feb 2018 11:02:50 +0000
Message-ID: <60670590-0517-7fad-eed3-dac8fbf98403@st.com>
References: <1518025389-3677-1-git-send-email-hugues.fruchet@st.com>
 <727ee222-20f1-23d3-fdff-4b985e24593d@xs4all.nl>
In-Reply-To: <727ee222-20f1-23d3-fdff-4b985e24593d@xs4all.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A5928DCBF0D1A4186AA5EB14A42D28E@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-08_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w18B3J6m013151

Thanks Hans,
v2 sent, rebased on your helpers !
Best regards,
Hugues.

On 02/07/2018 06:52 PM, Hans Verkuil wrote:
> On 02/07/2018 06:43 PM, Hugues Fruchet wrote:
>> Add g/s_parm framerate support by calling subdev
>> g/s_frame_interval ops.
>> This allows user to control sensor framerate by
>> calling ioctl G/S_PARM.
>>
>> Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
>> ---
>>   drivers/media/platform/stm32/stm32-dcmi.c | 49 +++++++++++++++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>
>> diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
>> index ab555d4..8197554 100644
>> --- a/drivers/media/platform/stm32/stm32-dcmi.c
>> +++ b/drivers/media/platform/stm32/stm32-dcmi.c
>> @@ -1151,6 +1151,52 @@ static int dcmi_enum_framesizes(struct file *file, void *fh,
>>   	return 0;
>>   }
>>   
>> +static int dcmi_g_parm(struct file *file, void *priv,
>> +		       struct v4l2_streamparm *p)
>> +{
>> +	struct stm32_dcmi *dcmi = video_drvdata(file);
>> +	struct v4l2_subdev_frame_interval ival = { 0 };
>> +	int ret;
>> +
>> +	if (p->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
>> +		return -EINVAL;
>> +
>> +	p->parm.capture.capability = V4L2_CAP_TIMEPERFRAME;
>> +	ret = v4l2_subdev_call(dcmi->entity.subdev, video,
>> +			       g_frame_interval, &ival);
>> +	if (ret)
>> +		return ret;
>> +
>> +	p->parm.capture.timeperframe = ival.interval;
>> +
>> +	return ret;
>> +}
> 
> This function and the next can be simplified by using the help functions
> introduced here:
> 
> https://git.linuxtv.org/hverkuil/media_tree.git/log/?h=parm
> 
> I'll make a pull request for this later this week, so it's probably a good
> idea to base your code on this as well.
> 
> Regards,
> 
> 	Hans
> 
>> +
>> +static int dcmi_s_parm(struct file *file, void *priv,
>> +		       struct v4l2_streamparm *p)
>> +{
>> +	struct stm32_dcmi *dcmi = video_drvdata(file);
>> +	struct v4l2_subdev_frame_interval ival = {
>> +		0,
>> +		p->parm.capture.timeperframe
>> +	};
>> +	int ret;
>> +
>> +	if (p->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
>> +		return -EINVAL;
>> +
>> +	memset(&p->parm, 0, sizeof(p->parm));
>> +	p->parm.capture.capability = V4L2_CAP_TIMEPERFRAME;
>> +	ret = v4l2_subdev_call(dcmi->entity.subdev, video,
>> +			       s_frame_interval, &ival);
>> +	if (ret)
>> +		return ret;
>> +
>> +	p->parm.capture.timeperframe = ival.interval;
>> +
>> +	return ret;
>> +}
>> +
>>   static int dcmi_enum_frameintervals(struct file *file, void *fh,
>>   				    struct v4l2_frmivalenum *fival)
>>   {
>> @@ -1253,6 +1299,9 @@ static int dcmi_release(struct file *file)
>>   	.vidioc_g_input			= dcmi_g_input,
>>   	.vidioc_s_input			= dcmi_s_input,
>>   
>> +	.vidioc_g_parm			= dcmi_g_parm,
>> +	.vidioc_s_parm			= dcmi_s_parm,
>> +
>>   	.vidioc_enum_framesizes		= dcmi_enum_framesizes,
>>   	.vidioc_enum_frameintervals	= dcmi_enum_frameintervals,
>>   
>>
> 
