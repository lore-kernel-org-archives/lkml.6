Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754358AbeDPJGH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:06:07 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55432 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754240AbeDPJGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:06:06 -0400
Date: Mon, 16 Apr 2018 12:05:27 +0300
From: kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
To: kbuild@01.org, Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc: kbuild-all@01.org, Takashi Iwai <tiwai@suse.com>,
        Jorge <jorge.sanjuan@codethink.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ALSA: usb: add UAC3 BADD profiles support
Message-ID: <20180416090527.yejas65ktstgflir@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523658266-2259-5-git-send-email-ruslan.bilovol@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8864 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804160084
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ruslan,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Ruslan-Bilovol/USB-Audio-Device-Class-3-0-BADD-profiles-support/20180414-182703
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next

smatch warnings:
sound/usb/stream.c:964 snd_usb_get_audioformat_uac3() warn: possible memory leak of 'chmap'

# https://github.com/0day-ci/linux/commit/7e255927f3e697fce36dcd48f205a7997771ed4d
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 7e255927f3e697fce36dcd48f205a7997771ed4d
vim +/chmap +964 sound/usb/stream.c

9a2fe9b801 Ruslan Bilovol 2018-03-21   791  
1145e3d13b Ruslan Bilovol 2018-04-14   792  static struct audioformat *
1145e3d13b Ruslan Bilovol 2018-04-14   793  snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
1145e3d13b Ruslan Bilovol 2018-04-14   794  			     struct usb_host_interface *alts,
1145e3d13b Ruslan Bilovol 2018-04-14   795  			     int iface_no, int altno, int stream)
1145e3d13b Ruslan Bilovol 2018-04-14   796  {
1145e3d13b Ruslan Bilovol 2018-04-14   797  	struct usb_device *dev = chip->dev;
9a2fe9b801 Ruslan Bilovol 2018-03-21   798  	struct uac3_input_terminal_descriptor *input_term;
9a2fe9b801 Ruslan Bilovol 2018-03-21   799  	struct uac3_output_terminal_descriptor *output_term;
9a2fe9b801 Ruslan Bilovol 2018-03-21   800  	struct uac3_cluster_header_descriptor *cluster;
7e255927f3 Ruslan Bilovol 2018-04-14   801  	struct uac3_as_header_descriptor *as = NULL;
9a2fe9b801 Ruslan Bilovol 2018-03-21   802  	struct uac3_hc_descriptor_header hc_header;
1145e3d13b Ruslan Bilovol 2018-04-14   803  	struct snd_pcm_chmap_elem *chmap;
7e255927f3 Ruslan Bilovol 2018-04-14   804  	unsigned char badd_profile;
7e255927f3 Ruslan Bilovol 2018-04-14   805  	u64 badd_formats  = 0;
1145e3d13b Ruslan Bilovol 2018-04-14   806  	unsigned int num_channels;
1145e3d13b Ruslan Bilovol 2018-04-14   807  	struct audioformat *fp;
9a2fe9b801 Ruslan Bilovol 2018-03-21   808  	u16 cluster_id, wLength;
1145e3d13b Ruslan Bilovol 2018-04-14   809  	int clock = 0;
1145e3d13b Ruslan Bilovol 2018-04-14   810  	int err;
9a2fe9b801 Ruslan Bilovol 2018-03-21   811  
7e255927f3 Ruslan Bilovol 2018-04-14   812  	badd_profile = chip->badd_profile;
7e255927f3 Ruslan Bilovol 2018-04-14   813  
7e255927f3 Ruslan Bilovol 2018-04-14   814  	if (badd_profile >= UAC3_FUNCTION_SUBCLASS_GENERIC_IO) {
7e255927f3 Ruslan Bilovol 2018-04-14   815  		unsigned int maxpacksize =
7e255927f3 Ruslan Bilovol 2018-04-14   816  			le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
7e255927f3 Ruslan Bilovol 2018-04-14   817  
7e255927f3 Ruslan Bilovol 2018-04-14   818  		switch (maxpacksize) {
7e255927f3 Ruslan Bilovol 2018-04-14   819  		default:
7e255927f3 Ruslan Bilovol 2018-04-14   820  			dev_err(&dev->dev,
7e255927f3 Ruslan Bilovol 2018-04-14   821  				"%u:%d : incorrect wMaxPacketSize for BADD profile\n",
7e255927f3 Ruslan Bilovol 2018-04-14   822  				iface_no, altno);
7e255927f3 Ruslan Bilovol 2018-04-14   823  			return NULL;
7e255927f3 Ruslan Bilovol 2018-04-14   824  		case UAC3_BADD_EP_MAXPSIZE_SYNC_MONO_16:
7e255927f3 Ruslan Bilovol 2018-04-14   825  		case UAC3_BADD_EP_MAXPSIZE_ASYNC_MONO_16:
7e255927f3 Ruslan Bilovol 2018-04-14   826  			badd_formats = SNDRV_PCM_FMTBIT_S16_LE;
7e255927f3 Ruslan Bilovol 2018-04-14   827  			num_channels = 1;
7e255927f3 Ruslan Bilovol 2018-04-14   828  			break;
7e255927f3 Ruslan Bilovol 2018-04-14   829  		case UAC3_BADD_EP_MAXPSIZE_SYNC_MONO_24:
7e255927f3 Ruslan Bilovol 2018-04-14   830  		case UAC3_BADD_EP_MAXPSIZE_ASYNC_MONO_24:
7e255927f3 Ruslan Bilovol 2018-04-14   831  			badd_formats = SNDRV_PCM_FMTBIT_S24_3LE;
7e255927f3 Ruslan Bilovol 2018-04-14   832  			num_channels = 1;
7e255927f3 Ruslan Bilovol 2018-04-14   833  			break;
7e255927f3 Ruslan Bilovol 2018-04-14   834  		case UAC3_BADD_EP_MAXPSIZE_SYNC_STEREO_16:
7e255927f3 Ruslan Bilovol 2018-04-14   835  		case UAC3_BADD_EP_MAXPSIZE_ASYNC_STEREO_16:
7e255927f3 Ruslan Bilovol 2018-04-14   836  			badd_formats = SNDRV_PCM_FMTBIT_S16_LE;
7e255927f3 Ruslan Bilovol 2018-04-14   837  			num_channels = 2;
7e255927f3 Ruslan Bilovol 2018-04-14   838  			break;
7e255927f3 Ruslan Bilovol 2018-04-14   839  		case UAC3_BADD_EP_MAXPSIZE_SYNC_STEREO_24:
7e255927f3 Ruslan Bilovol 2018-04-14   840  		case UAC3_BADD_EP_MAXPSIZE_ASYNC_STEREO_24:
7e255927f3 Ruslan Bilovol 2018-04-14   841  			badd_formats = SNDRV_PCM_FMTBIT_S24_3LE;
7e255927f3 Ruslan Bilovol 2018-04-14   842  			num_channels = 2;
7e255927f3 Ruslan Bilovol 2018-04-14   843  			break;
7e255927f3 Ruslan Bilovol 2018-04-14   844  		}
7e255927f3 Ruslan Bilovol 2018-04-14   845  
7e255927f3 Ruslan Bilovol 2018-04-14   846  		chmap = kzalloc(sizeof(*chmap), GFP_KERNEL);
7e255927f3 Ruslan Bilovol 2018-04-14   847  		if (!chmap)
7e255927f3 Ruslan Bilovol 2018-04-14   848  			return ERR_PTR(-ENOMEM);
7e255927f3 Ruslan Bilovol 2018-04-14   849  
7e255927f3 Ruslan Bilovol 2018-04-14   850  		if (num_channels == 1) {
7e255927f3 Ruslan Bilovol 2018-04-14   851  			chmap->map[0] = SNDRV_CHMAP_MONO;
7e255927f3 Ruslan Bilovol 2018-04-14   852  		} else {
7e255927f3 Ruslan Bilovol 2018-04-14   853  			chmap->map[0] = SNDRV_CHMAP_FL;
7e255927f3 Ruslan Bilovol 2018-04-14   854  			chmap->map[1] = SNDRV_CHMAP_FR;
7e255927f3 Ruslan Bilovol 2018-04-14   855  		}
7e255927f3 Ruslan Bilovol 2018-04-14   856  
7e255927f3 Ruslan Bilovol 2018-04-14   857  		chmap->channels = num_channels;
7e255927f3 Ruslan Bilovol 2018-04-14   858  		clock = UAC3_BADD_CS_ID9;
7e255927f3 Ruslan Bilovol 2018-04-14   859  		goto found_clock;
7e255927f3 Ruslan Bilovol 2018-04-14   860  	}
7e255927f3 Ruslan Bilovol 2018-04-14   861  
1145e3d13b Ruslan Bilovol 2018-04-14   862  	as = snd_usb_find_csint_desc(alts->extra, alts->extralen,
9a2fe9b801 Ruslan Bilovol 2018-03-21   863  				     NULL, UAC_AS_GENERAL);
9a2fe9b801 Ruslan Bilovol 2018-03-21   864  	if (!as) {
9a2fe9b801 Ruslan Bilovol 2018-03-21   865  		dev_err(&dev->dev,
9a2fe9b801 Ruslan Bilovol 2018-03-21   866  			"%u:%d : UAC_AS_GENERAL descriptor not found\n",
9a2fe9b801 Ruslan Bilovol 2018-03-21   867  			iface_no, altno);
1145e3d13b Ruslan Bilovol 2018-04-14   868  		return NULL;
e8e8babf56 Daniel Mack    2011-09-12   869  	}
e8e8babf56 Daniel Mack    2011-09-12   870  
9a2fe9b801 Ruslan Bilovol 2018-03-21   871  	if (as->bLength < sizeof(*as)) {
9a2fe9b801 Ruslan Bilovol 2018-03-21   872  		dev_err(&dev->dev,
9a2fe9b801 Ruslan Bilovol 2018-03-21   873  			"%u:%d : invalid UAC_AS_GENERAL desc\n",
9a2fe9b801 Ruslan Bilovol 2018-03-21   874  			iface_no, altno);
1145e3d13b Ruslan Bilovol 2018-04-14   875  		return NULL;
9a2fe9b801 Ruslan Bilovol 2018-03-21   876  	}
9a2fe9b801 Ruslan Bilovol 2018-03-21   877  
9a2fe9b801 Ruslan Bilovol 2018-03-21   878  	cluster_id = le16_to_cpu(as->wClusterDescrID);
9a2fe9b801 Ruslan Bilovol 2018-03-21   879  	if (!cluster_id) {
9a2fe9b801 Ruslan Bilovol 2018-03-21   880  		dev_err(&dev->dev,
9a2fe9b801 Ruslan Bilovol 2018-03-21   881  			"%u:%d : no cluster descriptor\n",
9a2fe9b801 Ruslan Bilovol 2018-03-21   882  			iface_no, altno);
1145e3d13b Ruslan Bilovol 2018-04-14   883  		return NULL;
9a2fe9b801 Ruslan Bilovol 2018-03-21   884  	}
9a2fe9b801 Ruslan Bilovol 2018-03-21   885  
9a2fe9b801 Ruslan Bilovol 2018-03-21   886  	/*
9a2fe9b801 Ruslan Bilovol 2018-03-21   887  	 * Get number of channels and channel map through
9a2fe9b801 Ruslan Bilovol 2018-03-21   888  	 * High Capability Cluster Descriptor
9a2fe9b801 Ruslan Bilovol 2018-03-21   889  	 *
9a2fe9b801 Ruslan Bilovol 2018-03-21   890  	 * First step: get High Capability header and
9a2fe9b801 Ruslan Bilovol 2018-03-21   891  	 * read size of Cluster Descriptor
9a2fe9b801 Ruslan Bilovol 2018-03-21   892  	 */
9a2fe9b801 Ruslan Bilovol 2018-03-21   893  	err = snd_usb_ctl_msg(chip->dev,
9a2fe9b801 Ruslan Bilovol 2018-03-21   894  			usb_rcvctrlpipe(chip->dev, 0),
9a2fe9b801 Ruslan Bilovol 2018-03-21   895  			UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
9a2fe9b801 Ruslan Bilovol 2018-03-21   896  			USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
9a2fe9b801 Ruslan Bilovol 2018-03-21   897  			cluster_id,
9a2fe9b801 Ruslan Bilovol 2018-03-21   898  			snd_usb_ctrl_intf(chip),
9a2fe9b801 Ruslan Bilovol 2018-03-21   899  			&hc_header, sizeof(hc_header));
9a2fe9b801 Ruslan Bilovol 2018-03-21   900  	if (err < 0)
1145e3d13b Ruslan Bilovol 2018-04-14   901  		return ERR_PTR(err);
9a2fe9b801 Ruslan Bilovol 2018-03-21   902  	else if (err != sizeof(hc_header)) {
9a2fe9b801 Ruslan Bilovol 2018-03-21   903  		dev_err(&dev->dev,
9a2fe9b801 Ruslan Bilovol 2018-03-21   904  			"%u:%d : can't get High Capability descriptor\n",
9a2fe9b801 Ruslan Bilovol 2018-03-21   905  			iface_no, altno);
1145e3d13b Ruslan Bilovol 2018-04-14   906  		return ERR_PTR(-EIO);
9a2fe9b801 Ruslan Bilovol 2018-03-21   907  	}
9a2fe9b801 Ruslan Bilovol 2018-03-21   908  
9a2fe9b801 Ruslan Bilovol 2018-03-21   909  	/*
9a2fe9b801 Ruslan Bilovol 2018-03-21   910  	 * Second step: allocate needed amount of memory
9a2fe9b801 Ruslan Bilovol 2018-03-21   911  	 * and request Cluster Descriptor
9a2fe9b801 Ruslan Bilovol 2018-03-21   912  	 */
9a2fe9b801 Ruslan Bilovol 2018-03-21   913  	wLength = le16_to_cpu(hc_header.wLength);
9a2fe9b801 Ruslan Bilovol 2018-03-21   914  	cluster = kzalloc(wLength, GFP_KERNEL);
9a2fe9b801 Ruslan Bilovol 2018-03-21   915  	if (!cluster)
1145e3d13b Ruslan Bilovol 2018-04-14   916  		return ERR_PTR(-ENOMEM);
9a2fe9b801 Ruslan Bilovol 2018-03-21   917  	err = snd_usb_ctl_msg(chip->dev,
9a2fe9b801 Ruslan Bilovol 2018-03-21   918  			usb_rcvctrlpipe(chip->dev, 0),
9a2fe9b801 Ruslan Bilovol 2018-03-21   919  			UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
9a2fe9b801 Ruslan Bilovol 2018-03-21   920  			USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
9a2fe9b801 Ruslan Bilovol 2018-03-21   921  			cluster_id,
9a2fe9b801 Ruslan Bilovol 2018-03-21   922  			snd_usb_ctrl_intf(chip),
9a2fe9b801 Ruslan Bilovol 2018-03-21   923  			cluster, wLength);
9a2fe9b801 Ruslan Bilovol 2018-03-21   924  	if (err < 0) {
9a2fe9b801 Ruslan Bilovol 2018-03-21   925  		kfree(cluster);
1145e3d13b Ruslan Bilovol 2018-04-14   926  		return ERR_PTR(err);
9a2fe9b801 Ruslan Bilovol 2018-03-21   927  	} else if (err != wLength) {
9a2fe9b801 Ruslan Bilovol 2018-03-21   928  		dev_err(&dev->dev,
9a2fe9b801 Ruslan Bilovol 2018-03-21   929  			"%u:%d : can't get Cluster Descriptor\n",
9a2fe9b801 Ruslan Bilovol 2018-03-21   930  			iface_no, altno);
9a2fe9b801 Ruslan Bilovol 2018-03-21   931  		kfree(cluster);
1145e3d13b Ruslan Bilovol 2018-04-14   932  		return ERR_PTR(-EIO);
9a2fe9b801 Ruslan Bilovol 2018-03-21   933  	}
9a2fe9b801 Ruslan Bilovol 2018-03-21   934  
9a2fe9b801 Ruslan Bilovol 2018-03-21   935  	num_channels = cluster->bNrChannels;
1145e3d13b Ruslan Bilovol 2018-04-14   936  	chmap = convert_chmap_v3(cluster);
9a2fe9b801 Ruslan Bilovol 2018-03-21   937  	kfree(cluster);
9a2fe9b801 Ruslan Bilovol 2018-03-21   938  
1145e3d13b Ruslan Bilovol 2018-04-14   939  	/*
1145e3d13b Ruslan Bilovol 2018-04-14   940  	 * lookup the terminal associated to this interface
1145e3d13b Ruslan Bilovol 2018-04-14   941  	 * to extract the clock
1145e3d13b Ruslan Bilovol 2018-04-14   942  	 */
1145e3d13b Ruslan Bilovol 2018-04-14   943  	input_term = snd_usb_find_input_terminal_descriptor(chip->ctrl_intf,
9a2fe9b801 Ruslan Bilovol 2018-03-21   944  							    as->bTerminalLink);
9a2fe9b801 Ruslan Bilovol 2018-03-21   945  	if (input_term) {
9a2fe9b801 Ruslan Bilovol 2018-03-21   946  		clock = input_term->bCSourceID;
1145e3d13b Ruslan Bilovol 2018-04-14   947  		goto found_clock;
9a2fe9b801 Ruslan Bilovol 2018-03-21   948  	}
9a2fe9b801 Ruslan Bilovol 2018-03-21   949  
9a2fe9b801 Ruslan Bilovol 2018-03-21   950  	output_term = snd_usb_find_output_terminal_descriptor(chip->ctrl_intf,
9a2fe9b801 Ruslan Bilovol 2018-03-21   951  							     as->bTerminalLink);
9a2fe9b801 Ruslan Bilovol 2018-03-21   952  	if (output_term) {
9a2fe9b801 Ruslan Bilovol 2018-03-21   953  		clock = output_term->bCSourceID;
1145e3d13b Ruslan Bilovol 2018-04-14   954  		goto found_clock;
9a2fe9b801 Ruslan Bilovol 2018-03-21   955  	}
9a2fe9b801 Ruslan Bilovol 2018-03-21   956  
1145e3d13b Ruslan Bilovol 2018-04-14   957  	dev_err(&dev->dev, "%u:%d : bogus bTerminalLink %d\n",
9a2fe9b801 Ruslan Bilovol 2018-03-21   958  			iface_no, altno, as->bTerminalLink);
1145e3d13b Ruslan Bilovol 2018-04-14   959  	return NULL;
e8e8babf56 Daniel Mack    2011-09-12   960  
1145e3d13b Ruslan Bilovol 2018-04-14   961  found_clock:
e8e8babf56 Daniel Mack    2011-09-12   962  	fp = kzalloc(sizeof(*fp), GFP_KERNEL);
9ecb2406de Markus Elfring 2017-08-11   963  	if (!fp)
1145e3d13b Ruslan Bilovol 2018-04-14  @964  		return ERR_PTR(-ENOMEM);
e8e8babf56 Daniel Mack    2011-09-12   965  
e8e8babf56 Daniel Mack    2011-09-12   966  	fp->iface = iface_no;
e8e8babf56 Daniel Mack    2011-09-12   967  	fp->altsetting = altno;
e8e8babf56 Daniel Mack    2011-09-12   968  	fp->endpoint = get_endpoint(alts, 0)->bEndpointAddress;
e8e8babf56 Daniel Mack    2011-09-12   969  	fp->ep_attr = get_endpoint(alts, 0)->bmAttributes;
e8e8babf56 Daniel Mack    2011-09-12   970  	fp->datainterval = snd_usb_parse_datainterval(chip, alts);
1145e3d13b Ruslan Bilovol 2018-04-14   971  	fp->protocol = UAC_VERSION_3;
e8e8babf56 Daniel Mack    2011-09-12   972  	fp->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
e8e8babf56 Daniel Mack    2011-09-12   973  	fp->channels = num_channels;
e8e8babf56 Daniel Mack    2011-09-12   974  	if (snd_usb_get_speed(dev) == USB_SPEED_HIGH)
e8e8babf56 Daniel Mack    2011-09-12   975  		fp->maxpacksize = (((fp->maxpacksize >> 11) & 3) + 1)
e8e8babf56 Daniel Mack    2011-09-12   976  				* (fp->maxpacksize & 0x7ff);
e8e8babf56 Daniel Mack    2011-09-12   977  	fp->clock = clock;
1145e3d13b Ruslan Bilovol 2018-04-14   978  	fp->chmap = chmap;
836b34a935 Vladis Dronov  2016-03-31   979  	INIT_LIST_HEAD(&fp->list);
e8e8babf56 Daniel Mack    2011-09-12   980  
7e255927f3 Ruslan Bilovol 2018-04-14   981  	if (badd_profile >= UAC3_FUNCTION_SUBCLASS_GENERIC_IO) {
7e255927f3 Ruslan Bilovol 2018-04-14   982  		fp->attributes = 0; /* No attributes */
7e255927f3 Ruslan Bilovol 2018-04-14   983  
7e255927f3 Ruslan Bilovol 2018-04-14   984  		fp->fmt_type = UAC_FORMAT_TYPE_I;
7e255927f3 Ruslan Bilovol 2018-04-14   985  		fp->formats = badd_formats;
7e255927f3 Ruslan Bilovol 2018-04-14   986  
7e255927f3 Ruslan Bilovol 2018-04-14   987  		fp->nr_rates = 0;	/* SNDRV_PCM_RATE_CONTINUOUS */
7e255927f3 Ruslan Bilovol 2018-04-14   988  		fp->rate_min = UAC3_BADD_SAMPLING_RATE;
7e255927f3 Ruslan Bilovol 2018-04-14   989  		fp->rate_max = UAC3_BADD_SAMPLING_RATE;
7e255927f3 Ruslan Bilovol 2018-04-14   990  		fp->rates = SNDRV_PCM_RATE_CONTINUOUS;
7e255927f3 Ruslan Bilovol 2018-04-14   991  
7e255927f3 Ruslan Bilovol 2018-04-14   992  	} else {
7e255927f3 Ruslan Bilovol 2018-04-14   993  		fp->attributes = parse_uac_endpoint_attributes(chip, alts,
7e255927f3 Ruslan Bilovol 2018-04-14   994  							       UAC_VERSION_3,
7e255927f3 Ruslan Bilovol 2018-04-14   995  							       iface_no);
e8e8babf56 Daniel Mack    2011-09-12   996  		/* ok, let's parse further... */
1145e3d13b Ruslan Bilovol 2018-04-14   997  		if (snd_usb_parse_audio_format_v3(chip, fp, as, stream) < 0) {
e8e8babf56 Daniel Mack    2011-09-12   998  			kfree(fp->rate_table);
e8e8babf56 Daniel Mack    2011-09-12   999  			kfree(fp);
1145e3d13b Ruslan Bilovol 2018-04-14  1000  			return NULL;
e8e8babf56 Daniel Mack    2011-09-12  1001  		}
7e255927f3 Ruslan Bilovol 2018-04-14  1002  	}
9a2fe9b801 Ruslan Bilovol 2018-03-21  1003  
1145e3d13b Ruslan Bilovol 2018-04-14  1004  	return fp;
1145e3d13b Ruslan Bilovol 2018-04-14  1005  }
9a2fe9b801 Ruslan Bilovol 2018-03-21  1006  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
