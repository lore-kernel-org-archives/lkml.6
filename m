Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933913AbeEWSGF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 14:06:05 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:33080 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933706AbeEWSGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 14:06:01 -0400
Date: Wed, 23 May 2018 11:06:00 -0700
From: Vito Caputo <vcaputo@pengaru.com>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, daniel.vetter@ffwll.ch
Subject: Re: [REGRESSION] v4.17-rc4: xgalaga fails to start in fullscreen
 (default) mode
Message-ID: <20180523180600.n66ffkumkvhqnawk@shells.gnugeneration.com>
References: <20180521195320.6stbpnebgjowxwjp@shells.gnugeneration.com>
 <20180521215718.7zwhhdanpnibp6la@shells.gnugeneration.com>
 <20180523094919.s47ldq33hhbnodu2@shells.gnugeneration.com>
 <20180523131805.GK23723@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180523131805.GK23723@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 04:18:05PM +0300, Ville Syrjälä wrote:
> On Wed, May 23, 2018 at 02:49:19AM -0700, Vito Caputo wrote:
> > On Mon, May 21, 2018 at 02:57:18PM -0700, Vito Caputo wrote:
> > > On Mon, May 21, 2018 at 12:53:20PM -0700, Vito Caputo wrote:
> > > > Hello all,
> > > > 
> > > > 4.17-rc4 (my latest kernel ATM) consistently fails to start xgalaga
> > > > without -window.  I will try find time to build the latest rc this
> > > > evening.
> > > > 
> > > > > ~$ xgalaga
> > > > > X Error of failed request:  BadValue (integer parameter out of range for operation)
> > > > >   Major opcode of failed request:  152 (XFree86-VidModeExtension)
> > > > >   Minor opcode of failed request:  10 (XF86VidModeSwitchToMode)
> > > > >   Value in failed request:  0x120004e
> > > > >   Serial number of failed request:  199
> > > > >   Current serial number in output stream:  203
> > > > 
> > > > Haven't dug into this much yet, only did a perfunctory check by booting into a
> > > > few older kernels (4.11, 4.12, 4.16) and the problem is absent on all of them.
> > > > It appears to be a 4.17-specific regression right now.
> > > > 
> > > > Also observed, though this is surely a different regression, the game
> > > > ran like molasses with -window, showing some prominent kworkers in top:
> > > > 
> > > >   692 vc        20   0  312852  45884  20556 R  32.0  1.2   0:08.69 Xorg           
> > > >   102 root      20   0       0      0      0 R  11.2  0.0   0:01.43 kworker/1:3    
> > > >    94 root      20   0       0      0      0 I   8.9  0.0   0:00.83 kworker/0:2    
> > > >   696 vc        20   0   39948   4124   2912 S   1.0  0.1   0:05.57 vwm            
> > > >   902 vc        30  10   46372   4144   3500 S   0.7  0.1   0:00.08 xgalaga        
> > > >   891 vc        30  10   44924   3868   3156 R   0.3  0.1   0:00.09 top            
> > > >   903 vc        30  10    4180   1184   1100 S   0.3  0.0   0:00.01 xgal.sndsrv.oss
> > > > 
> > > > The windowed performance issue was observed on the older kernels tested
> > > > as well, though 4.11 felt better and didn't have the busy kworkers.
> > > > 
> > > > I have not attempted to play xgalaga for ages, but it used to be perfectly
> > > > playable on this machine in windowed mode when I last did.
> > > > 
> > > > Machine is the venerable Thinkpad X61s, 1.8Ghz, Debian 9, config attached.
> > > > 
> > > 
> > > Just built and booted v4.17-rc6, still broken.
> > 
> > Bisected to:
> > 
> > e995ca0b8139c5f6807095464e969931b443f55a is the first bad commit
> > commit e995ca0b8139c5f6807095464e969931b443f55a
> > Author: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Date:   Tue Nov 14 20:32:58 2017 +0200
> > 
> >     drm/i915: Provide a device level .mode_valid() hook
> >     
> >     We never support certain mode flags etc. Reject those early on in the
> >     mode_config.mode_valid() hook. That allows us to remove some duplicated
> >     checks from the connector .mode_valid() hooks, and it guarantees that
> >     we never see those flags even from user mode as the
> >     mode_config.mode_valid() hooks gets executed for those as well.
> >     
> >     Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> >     Link: https://patchwork.freedesktop.org/patch/msgid/20171114183258.16976-11-ville.syrjala@linux.intel.com
> >     Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Hmm. I guess xgalaga passes some garbage in via xf86vidmode which
> the ddx doesn't validate before passing it on to the kernel. So far
> I can't reproduce the problem here unfortnately.
> 
> Can you try the following patch and reproduce the problem with
> drm.debug=0xe passed to the kernel so that we can seewhat the bad
> modeline looks like?
> 

dmesg after xgalaga fails:

```
[   75.617448] [drm:drm_mode_convert_umode] Bad user mode:
[   75.617455] [drm:drm_mode_debug_printmodeline] Modeline 57:"800x600" 0 81000 800 832 928 1080 600 600 602 625 0x0 0x25
[   75.617458] [drm:drm_mode_setcrtc] Invalid mode
```

xrandr --verbose:

```
Screen 0: minimum 320 x 200, current 1024 x 768, maximum 8192 x 8192
LVDS-1 connected primary 1024x768+0+0 (0x44) normal (normal left inverted right x axis y axis) 246mm x 184mm
	Identifier: 0x41
	Timestamp:  23375
	Subpixel:   horizontal rgb
	Gamma:      1.0:1.0:1.0
	Brightness: 1.0
	Clones:    
	CRTC:       0
	CRTCs:      0 1
	Transform:  1.000000 0.000000 0.000000
	            0.000000 1.000000 0.000000
	            0.000000 0.000000 1.000000
	           filter: 
	EDID: 
		00ffffffffffff0030ae004000000000
		3010010380191278eafe609555518726
		22505421080001010101010101010101
		01010101010128150040410026301888
		3600f6b800000018ed10004041002630
		18883600f6b9000000180000000f0061
		43326143280f01000daf0714000000fe
		004e31323158352d4c303620202000ed
	scaling mode: Full aspect 
		supported: Full, Center, Full aspect
	non-desktop: 0 
		range: (0, 1)
	link-status: Good 
		supported: Good, Bad
  1024x768 (0x44) 54.160MHz -HSync -VSync *current +preferred
        h: width  1024 start 1048 end 1184 total 1344 skew    0 clock  40.30KHz
        v: height  768 start  771 end  777 total  806           clock  50.00Hz
  1024x768 (0x45) 65.000MHz -HSync -VSync
        h: width  1024 start 1048 end 1184 total 1344 skew    0 clock  48.36KHz
        v: height  768 start  771 end  777 total  806           clock  60.00Hz
  1024x768 (0x46) 43.330MHz -HSync -VSync
        h: width  1024 start 1048 end 1184 total 1344 skew    0 clock  32.24KHz
        v: height  768 start  771 end  777 total  806           clock  40.00Hz
  960x720 (0x47) 117.000MHz -HSync +VSync DoubleScan
        h: width   960 start 1024 end 1128 total 1300 skew    0 clock  90.00KHz
        v: height  720 start  720 end  722 total  750           clock  60.00Hz
  928x696 (0x48) 109.150MHz -HSync +VSync DoubleScan
        h: width   928 start  976 end 1088 total 1264 skew    0 clock  86.35KHz
        v: height  696 start  696 end  698 total  719           clock  60.05Hz
  896x672 (0x49) 102.400MHz -HSync +VSync DoubleScan
        h: width   896 start  960 end 1060 total 1224 skew    0 clock  83.66KHz
        v: height  672 start  672 end  674 total  697           clock  60.01Hz
  960x600 (0x4a) 77.000MHz +HSync -VSync DoubleScan
        h: width   960 start  984 end 1000 total 1040 skew    0 clock  74.04KHz
        v: height  600 start  601 end  604 total  617           clock  60.00Hz
  960x540 (0x4b) 69.250MHz +HSync -VSync DoubleScan
        h: width   960 start  984 end 1000 total 1040 skew    0 clock  66.59KHz
        v: height  540 start  541 end  544 total  555           clock  59.99Hz
  800x600 (0x4c) 81.000MHz +HSync +VSync DoubleScan
        h: width   800 start  832 end  928 total 1080 skew    0 clock  75.00KHz
        v: height  600 start  600 end  602 total  625           clock  60.00Hz
  800x600 (0x4d) 40.000MHz +HSync +VSync
        h: width   800 start  840 end  968 total 1056 skew    0 clock  37.88KHz
        v: height  600 start  601 end  605 total  628           clock  60.32Hz
  800x600 (0x4e) 36.000MHz +HSync +VSync
        h: width   800 start  824 end  896 total 1024 skew    0 clock  35.16KHz
        v: height  600 start  601 end  603 total  625           clock  56.25Hz
  840x525 (0x4f) 73.125MHz -HSync +VSync DoubleScan
        h: width   840 start  892 end  980 total 1120 skew    0 clock  65.29KHz
        v: height  525 start  526 end  529 total  544           clock  60.01Hz
  840x525 (0x50) 59.500MHz +HSync -VSync DoubleScan
        h: width   840 start  864 end  880 total  920 skew    0 clock  64.67KHz
        v: height  525 start  526 end  529 total  540           clock  59.88Hz
  800x512 (0x51) 51.562MHz +HSync +VSync DoubleScan
        h: width   800 start  800 end  828 total  832 skew    0 clock  61.97KHz
        v: height  512 start  512 end  514 total  515           clock  60.17Hz
  700x525 (0x52) 61.000MHz +HSync +VSync DoubleScan
        h: width   700 start  744 end  820 total  940 skew    0 clock  64.89KHz
        v: height  525 start  526 end  532 total  541           clock  59.98Hz
  640x512 (0x53) 54.000MHz +HSync +VSync DoubleScan
        h: width   640 start  664 end  720 total  844 skew    0 clock  63.98KHz
        v: height  512 start  512 end  514 total  533           clock  60.02Hz
  720x450 (0x54) 53.250MHz -HSync +VSync DoubleScan
        h: width   720 start  760 end  836 total  952 skew    0 clock  55.93KHz
        v: height  450 start  451 end  454 total  467           clock  59.89Hz
  640x480 (0x55) 54.000MHz +HSync +VSync DoubleScan
        h: width   640 start  688 end  744 total  900 skew    0 clock  60.00KHz
        v: height  480 start  480 end  482 total  500           clock  60.00Hz
  640x480 (0x56) 25.175MHz -HSync -VSync
        h: width   640 start  656 end  752 total  800 skew    0 clock  31.47KHz
        v: height  480 start  490 end  492 total  525           clock  59.94Hz
  680x384 (0x57) 42.375MHz -HSync +VSync DoubleScan
        h: width   680 start  716 end  784 total  888 skew    0 clock  47.72KHz
        v: height  384 start  385 end  390 total  399           clock  59.80Hz
  680x384 (0x58) 36.000MHz +HSync -VSync DoubleScan
        h: width   680 start  704 end  720 total  760 skew    0 clock  47.37KHz
        v: height  384 start  385 end  390 total  395           clock  59.96Hz
  576x432 (0x59) 40.810MHz -HSync +VSync DoubleScan
        h: width   576 start  608 end  668 total  760 skew    0 clock  53.70KHz
        v: height  432 start  432 end  434 total  447           clock  60.06Hz
  512x384 (0x5a) 32.500MHz -HSync -VSync DoubleScan
        h: width   512 start  524 end  592 total  672 skew    0 clock  48.36KHz
        v: height  384 start  385 end  388 total  403           clock  60.00Hz
  400x300 (0x5b) 20.000MHz +HSync +VSync DoubleScan
        h: width   400 start  420 end  484 total  528 skew    0 clock  37.88KHz
        v: height  300 start  300 end  302 total  314           clock  60.32Hz
  400x300 (0x5c) 18.000MHz +HSync +VSync DoubleScan
        h: width   400 start  412 end  448 total  512 skew    0 clock  35.16KHz
        v: height  300 start  300 end  301 total  312           clock  56.34Hz
  320x240 (0x5d) 12.587MHz -HSync -VSync DoubleScan
        h: width   320 start  328 end  376 total  400 skew    0 clock  31.47KHz
        v: height  240 start  245 end  246 total  262           clock  60.05Hz
VGA-1 disconnected (normal left inverted right x axis y axis)
	Identifier: 0x42
	Timestamp:  23375
	Subpixel:   unknown
	Clones:    
	CRTCs:      0 1
	Transform:  1.000000 0.000000 0.000000
	            0.000000 1.000000 0.000000
	            0.000000 0.000000 1.000000
	           filter: 
	non-desktop: 0 
		range: (0, 1)
	link-status: Good 
		supported: Good, Bad
```

I took a quick glance at the xgalaga source, and it looks to supply
XF86VidModeSwitchToMode() with an unmodified XF86VidModeModeInfo chosen from
the array returned by XF86VidModeGetAllModeLines().

Thanks,
Vito Caputo
