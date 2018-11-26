Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4FCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E39220855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E39220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbeK0Duy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:50:54 -0500
Received: from smtprelay0081.hostedemail.com ([216.40.44.81]:42108 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726266AbeK0Duy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:50:54 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id B6F8F837F242;
        Mon, 26 Nov 2018 16:56:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sheep80_35decc2a17c63
X-Filterd-Recvd-Size: 10234
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon, 26 Nov 2018 16:56:10 +0000 (UTC)
Message-ID: <8a67fcf5cd421ab369787468248b37709bb4bac1.camel@perches.com>
Subject: Re: [PATCH] staging: iio: adc: ad7280a: check for devm_kasprint()
 failure
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Nicholas Mc Guire <der.herr@hofr.at>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        devel@driverdev.osuosl.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>
Date:   Mon, 26 Nov 2018 08:56:08 -0800
In-Reply-To: <20181126132612.GJ2970@unbuntlaptop>
References: <1543225144-27468-1-git-send-email-hofrat@osadl.org>
         <20181126130032.GJ3088@unbuntlaptop> <20181126131009.GA19931@osadl.at>
         <20181126132612.GJ2970@unbuntlaptop>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-26 at 16:26 +0300, Dan Carpenter wrote:
> On Mon, Nov 26, 2018 at 02:10:09PM +0100, Nicholas Mc Guire wrote:
> > On Mon, Nov 26, 2018 at 04:00:32PM +0300, Dan Carpenter wrote:
> > > On Mon, Nov 26, 2018 at 10:39:04AM +0100, Nicholas Mc Guire wrote:
> > > > devm_kasprintf() may return NULL on failure of internal allocation thus
> > > > the assignments to  attr.name  are not safe if not checked. On error
> > > > ad7280_attr_init() returns a negative return so -ENOMEM should be
> > > > OK here (passed on as return value of the probe function).
> > > > 
> > > > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > > > Fixes: 2051f25d2a26 ("iio: adc: New driver for AD7280A Lithium Ion Battery Monitoring System2")
> > > > ---
> > > > 
> > > > Problem located with an experimental coccinelle script
> > > > 
> > > > As using   if(!st->iio_attr[cnt].dev_attr.attr.name)  seamed quite
> > > > unreadable in this case the  (var  == NULL)  variant was used. Not
> > >                                    ^^
> > > Why two spaces?
> > 
> > just a typo 
> > 
> > > > sure if there are objections against this (checkpatch.pl issues
> > > > a CHECK on this).
> > > > 
> > > 
> > > You should just follow checkpatch rules here.  If you don't, someone
> > > else will just send a patch to make it checkpatch compliant.  One thing
> > > you could do is at the start of the loop do:
> > > 
> > > 	struct iio_dev_attr *attr = &st->iio_attr[cnt];
> > > 
> > > Then it becomes:
> > > 
> > > 	if (!attr->dev_attr.attr.name)
> > > 
> > > It's slightly more readable that way.  Keep in mind that we increment o
> > > cnt++ in the middle of the loop so you'll have to update attr as well.
> > > 
> > My understanding was that CHECK: notes are not strict rules but
> > those that may vary from case to case.
> 
> Checkpatch is just a script.  It's not a genius or the king of the
> world.

Or, as someone once wrote, more sentient than a squirrel.

> I actually agree with checkpatch on this one but it's a minor thing.
> Sometimes a maintainer will get obsessed with minor things.

Like #include file ordering by length or alphabet

> Btw, when I get annoyed with checkpatch, I feel like it's pretty obvious
> I am correct.  I'm not like other kernel developers who have debatable
> style preferences...  ;)

Yup.

btw:  Using temporaries like the below can reduce object
size a bit too. (allyesconfig)

$ size drivers/staging/iio/adc/ad7280a.o*
   text	   data	    bss	    dec	    hex	filename
  16287	   2848	    896	  20031	   4e3f	drivers/staging/iio/adc/ad7280a.o.new
  16623	   2848	    896	  20367	   4f8f	drivers/staging/iio/adc/ad7280a.o.old

---
 drivers/staging/iio/adc/ad7280a.c | 116 ++++++++++++++++++--------------------
 1 file changed, 56 insertions(+), 60 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 0bb9ab174f2a..1542285b492c 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -499,6 +499,7 @@ static const struct attribute_group ad7280_attrs_group = {
 static int ad7280_channel_init(struct ad7280_state *st)
 {
 	int dev, ch, cnt;
+	struct iio_chan_spec *chan;
 
 	st->channels = devm_kcalloc(&st->spi->dev, (st->slave_num + 1) * 12 + 2,
 				    sizeof(*st->channels), GFP_KERNEL);
@@ -508,51 +509,52 @@ static int ad7280_channel_init(struct ad7280_state *st)
 	for (dev = 0, cnt = 0; dev <= st->slave_num; dev++)
 		for (ch = AD7280A_CELL_VOLTAGE_1; ch <= AD7280A_AUX_ADC_6;
 			ch++, cnt++) {
+			chan = &st->channels[cnt];
 			if (ch < AD7280A_AUX_ADC_1) {
-				st->channels[cnt].type = IIO_VOLTAGE;
-				st->channels[cnt].differential = 1;
-				st->channels[cnt].channel = (dev * 6) + ch;
-				st->channels[cnt].channel2 =
-					st->channels[cnt].channel + 1;
+				chan->type = IIO_VOLTAGE;
+				chan->differential = 1;
+				chan->channel = (dev * 6) + ch;
+				chan->channel2 = chan->channel + 1;
 			} else {
-				st->channels[cnt].type = IIO_TEMP;
-				st->channels[cnt].channel = (dev * 6) + ch - 6;
+				chan->type = IIO_TEMP;
+				chan->channel = (dev * 6) + ch - 6;
 			}
-			st->channels[cnt].indexed = 1;
-			st->channels[cnt].info_mask_separate =
-				BIT(IIO_CHAN_INFO_RAW);
-			st->channels[cnt].info_mask_shared_by_type =
+			chan->indexed = 1;
+			chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+			chan->info_mask_shared_by_type =
 				BIT(IIO_CHAN_INFO_SCALE);
-			st->channels[cnt].address =
-				ad7280a_devaddr(dev) << 8 | ch;
-			st->channels[cnt].scan_index = cnt;
-			st->channels[cnt].scan_type.sign = 'u';
-			st->channels[cnt].scan_type.realbits = 12;
-			st->channels[cnt].scan_type.storagebits = 32;
-			st->channels[cnt].scan_type.shift = 0;
+			chan->address = ad7280a_devaddr(dev) << 8 | ch;
+			chan->scan_index = cnt;
+			chan->scan_type.sign = 'u';
+			chan->scan_type.realbits = 12;
+			chan->scan_type.storagebits = 32;
+			chan->scan_type.shift = 0;
 		}
 
-	st->channels[cnt].type = IIO_VOLTAGE;
-	st->channels[cnt].differential = 1;
-	st->channels[cnt].channel = 0;
-	st->channels[cnt].channel2 = dev * 6;
-	st->channels[cnt].address = AD7280A_ALL_CELLS;
-	st->channels[cnt].indexed = 1;
-	st->channels[cnt].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
-	st->channels[cnt].info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
-	st->channels[cnt].scan_index = cnt;
-	st->channels[cnt].scan_type.sign = 'u';
-	st->channels[cnt].scan_type.realbits = 32;
-	st->channels[cnt].scan_type.storagebits = 32;
-	st->channels[cnt].scan_type.shift = 0;
+	chan = &st->channels[cnt];
+	chan->type = IIO_VOLTAGE;
+	chan->differential = 1;
+	chan->channel = 0;
+	chan->channel2 = dev * 6;
+	chan->address = AD7280A_ALL_CELLS;
+	chan->indexed = 1;
+	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+	chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
+	chan->scan_index = cnt;
+	chan->scan_type.sign = 'u';
+	chan->scan_type.realbits = 32;
+	chan->scan_type.storagebits = 32;
+	chan->scan_type.shift = 0;
+
 	cnt++;
-	st->channels[cnt].type = IIO_TIMESTAMP;
-	st->channels[cnt].channel = -1;
-	st->channels[cnt].scan_index = cnt;
-	st->channels[cnt].scan_type.sign = 's';
-	st->channels[cnt].scan_type.realbits = 64;
-	st->channels[cnt].scan_type.storagebits = 64;
-	st->channels[cnt].scan_type.shift = 0;
+	chan = &st->channels[cnt];
+	chan->type = IIO_TIMESTAMP;
+	chan->channel = -1;
+	chan->scan_index = cnt;
+	chan->scan_type.sign = 's';
+	chan->scan_type.realbits = 64;
+	chan->scan_type.storagebits = 64;
+	chan->scan_type.shift = 0;
 
 	return cnt + 1;
 }
@@ -561,6 +563,7 @@ static int ad7280_attr_init(struct ad7280_state *st)
 {
 	int dev, ch, cnt;
 	unsigned int index;
+	struct iio_dev_attr *iio;
 
 	st->iio_attr = devm_kcalloc(&st->spi->dev, 2, sizeof(*st->iio_attr) *
 				    (st->slave_num + 1) * AD7280A_CELLS_PER_DEV,
@@ -571,37 +574,30 @@ static int ad7280_attr_init(struct ad7280_state *st)
 	for (dev = 0, cnt = 0; dev <= st->slave_num; dev++)
 		for (ch = AD7280A_CELL_VOLTAGE_1; ch <= AD7280A_CELL_VOLTAGE_6;
 			ch++, cnt++) {
+			iio = &st->iio_attr[cnt];
 			index = dev * AD7280A_CELLS_PER_DEV + ch;
-			st->iio_attr[cnt].address =
-				ad7280a_devaddr(dev) << 8 | ch;
-			st->iio_attr[cnt].dev_attr.attr.mode =
-				0644;
-			st->iio_attr[cnt].dev_attr.show =
-				ad7280_show_balance_sw;
-			st->iio_attr[cnt].dev_attr.store =
-				ad7280_store_balance_sw;
-			st->iio_attr[cnt].dev_attr.attr.name =
+			iio->address = ad7280a_devaddr(dev) << 8 | ch;
+			iio->dev_attr.attr.mode = 0644;
+			iio->dev_attr.show = ad7280_show_balance_sw;
+			iio->dev_attr.store = ad7280_store_balance_sw;
+			iio->dev_attr.attr.name =
 				devm_kasprintf(&st->spi->dev, GFP_KERNEL,
 					       "in%d-in%d_balance_switch_en",
 					       index, index + 1);
-			ad7280_attributes[cnt] =
-				&st->iio_attr[cnt].dev_attr.attr;
+			ad7280_attributes[cnt] = &iio->dev_attr.attr;
+
 			cnt++;
-			st->iio_attr[cnt].address =
-				ad7280a_devaddr(dev) << 8 |
+			iio = &st->iio_attr[cnt];
+			iio->address = ad7280a_devaddr(dev) << 8 |
 				(AD7280A_CB1_TIMER + ch);
-			st->iio_attr[cnt].dev_attr.attr.mode =
-				0644;
-			st->iio_attr[cnt].dev_attr.show =
-				ad7280_show_balance_timer;
-			st->iio_attr[cnt].dev_attr.store =
-				ad7280_store_balance_timer;
-			st->iio_attr[cnt].dev_attr.attr.name =
+			iio->dev_attr.attr.mode = 0644;
+			iio->dev_attr.show = ad7280_show_balance_timer;
+			iio->dev_attr.store = ad7280_store_balance_timer;
+			iio->dev_attr.attr.name =
 				devm_kasprintf(&st->spi->dev, GFP_KERNEL,
 					       "in%d-in%d_balance_timer",
 					       index, index + 1);
-			ad7280_attributes[cnt] =
-				&st->iio_attr[cnt].dev_attr.attr;
+			ad7280_attributes[cnt] = &iio->dev_attr.attr;
 		}
 
 	ad7280_attributes[cnt] = NULL;

